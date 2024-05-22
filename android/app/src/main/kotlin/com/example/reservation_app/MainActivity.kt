package com.example.reservation_app

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import java.io.IOException


class MainActivity: FlutterActivity() {
        private val _channel
        = "reservationsChannel"
val coroutineExceptionHandler = CoroutineExceptionHandler{_, throwable ->
    throwable.printStackTrace()
}
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            _channel
        ).setMethodCallHandler { call, result ->
        // Log.d("checkk","=call ${call.method}")
            if (call.method == "fetchReservations") {
                //                var response : Response? = null
                GlobalScope.launch(Dispatchers.IO + coroutineExceptionHandler) {
                    val client = OkHttpClient()
                // Log.d("checkk","-1")
                    val request = Request.Builder()
                        .url("https://qa-testing-backend-293b1363694d.herokuapp.com//api/v3/mobile-guests/user-events")
                        .get()
                        .addHeader("accept", "application/json")
                        .addHeader(
                            "Authorization",
                            "Bearer eyJhbGciOiJSUzI1NiJ9.eyJpZCI6MzAzLCJ0eXBlIjoidXNlciIsInJhbiI6IkJORU5WSVBOTlFUWVBMS0tVQ0JWIiwic3RhdHVzIjoxfQ.YGV-jGKZj1Lp4SqlM3aiF6Aov6YVF6lZRMpKvx_Zdrpjj4C1zE-JSTKtjVboQ9de58TUViyVOc4JwiktjF_4yxnYzIrw449s584j2GiqUpxfp6OPmfAj8BAbfN_M4RoU5PXEjhcNVh5uNRtxtvxZtpECrl72_22T4he3LbqISMNHzVh5eprIKIFLt_pM7cyRKt3Njf8I89CLnq5nUpiDHnMMForamKq9jubmiYPOHpFvijEE3-jusRk0F1T32zMY_0AELXnpqhbbx6HtmMdxBahnrUNyznacdVwaSrNus8vX01N8zEcfRvkRzYuqjnZXr9jrm2iriHq80iicUG99GQ"
                        )
                        .build()
                // Log.d("checkk","-2")
                    client.newCall(request).execute().use { response ->
                      if (!response.isSuccessful) throw IOException("Unexpected code $response")

                        // Log.d("checkk response body",response.peekBody(2048)!!.string())
                            val responseBody = response!!.body()?.string() ?: ""
                    result.success(responseBody)
                    }

                }

            } else {
                result.notImplemented()
            }
        }
    }
}

