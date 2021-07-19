package com.ara.flutter_scan_kit

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Color
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import com.huawei.hms.hmsscankit.ScanUtil
import com.huawei.hms.hmsscankit.WriterException
import com.huawei.hms.ml.scan.HmsBuildBitmapOption
import com.huawei.hms.ml.scan.HmsScan
import com.huawei.hms.ml.scan.HmsScanAnalyzerOptions
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.ByteArrayOutputStream
import java.util.*


/** FlutterScanKitPlugin */
class FlutterScanKitPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private val CAMERA_REQ_CODE = 111
    private val REQUEST_CODE_SCAN = 0X01

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private var result: Result? = null
    private var activity: Activity? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_scan_kit")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        this.result = result
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "startScan") {//扫码
            requestPermission()
        } else if (call.method == "generateCode") {//生产条码
            val content: String? = call.argument("content")
            val type: Int? = call.argument("type")
            val width: Int? = call.argument("width")
            val height: Int? = call.argument("height")
            val color: String? = call.argument("color")
            val logo: ByteArray? = call.argument("logo")
            generateCode(content, type, width, height, color, logo)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        onRequestPermissionsResultListener(binding)
        onActivityResultListener(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }

    /**
     * Apply for permissions.
     */
    private fun requestPermission() {
        ActivityCompat.requestPermissions(
                activity!!, arrayOf(Manifest.permission.CAMERA, Manifest.permission.READ_EXTERNAL_STORAGE,
                Manifest.permission.WRITE_EXTERNAL_STORAGE),
                CAMERA_REQ_CODE)
    }

    private fun onRequestPermissionsResultListener(binding: ActivityPluginBinding) {
        binding.addRequestPermissionsResultListener { requestCode: Int, permissions: Array<String?>?, grantResults: IntArray? ->
            if (permissions == null || grantResults == null) {
                return@addRequestPermissionsResultListener false
            }
            if (grantResults.size < 2 || grantResults[0] != PackageManager.PERMISSION_GRANTED || grantResults[1] != PackageManager.PERMISSION_GRANTED) {
                return@addRequestPermissionsResultListener false
            }
            //Default View Mode
            if (requestCode == CAMERA_REQ_CODE) {
                ScanUtil.startScan(activity, REQUEST_CODE_SCAN, HmsScanAnalyzerOptions.Creator().create())
            }
            false
        }
    }

    private fun onActivityResultListener(binding: ActivityPluginBinding) {
        binding.addActivityResultListener { requestCode: Int, resultCode: Int, data: Intent? ->
            if (resultCode != Activity.RESULT_OK || data == null) {
                return@addActivityResultListener false
            }
            //Default View
            if (requestCode == REQUEST_CODE_SCAN) {
                val obj: HmsScan? = data.getParcelableExtra(ScanUtil.RESULT)
                if (obj != null) {
                    val map: MutableMap<String, Any> = HashMap()
                    map["scanType"] = obj.getScanType()
                    map["scanTypeForm"] = obj.getScanTypeForm()
                    //获取条码原始的全部码值信息。只有当条码编码格式为UTF-8时才可以使用
                    map["value"] = obj.getOriginalValue()
                    //非UTF-8格式的条码使用
                    map["valueByte"] = obj.getOriginValueByte()
                    result!!.success(map)
                } else {
                    result!!.success(HashMap<Any, Any>())
                }
            }
            false
        }
    }

    /**
     * 生成条码
     */
    private fun generateCode(
            content: String? = "", type: Int?,
            width: Int?, height: Int?, color: String?,
            logo: ByteArray?
    ) {
        if (content == null || content.isEmpty()) {
            Toast.makeText(activity, "请输入生成内容", Toast.LENGTH_SHORT).show()
            return
        }
        try {
            //Generate the barcode.
            val options = HmsBuildBitmapOption.Creator()
                    .setBitmapBackgroundColor(Color.WHITE)
            if (color != null && color.length == 7) {
                val codeColor: Int = Color.parseColor(color)
                options.setBitmapColor(codeColor)
            }
            if (logo != null && logo.isNotEmpty()) {
                options.setQRLogoBitmap(byte2Bitmap(logo))
            }
            val bitmap = ScanUtil.buildBitmap(content, type ?: HmsScan.QRCODE_SCAN_TYPE,
                    width ?: 500, height ?: 500, options.create())
            val map: MutableMap<String, Any> = HashMap()
            map["code"] = bitmap2Byte(bitmap)
            result!!.success(map)
        } catch (e: WriterException) {
            Toast.makeText(activity, "参数错误！", Toast.LENGTH_SHORT).show()
        }
    }

    private fun bitmap2Byte(bitmap: Bitmap): ByteArray {
        val baos = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, baos)
        bitmap.recycle()
        val results = baos.toByteArray();
        baos.close()
        return results
    }

    private fun byte2Bitmap(bytes: ByteArray): Bitmap {
        return BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
    }
}
