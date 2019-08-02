package com.example.pwdflutter;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.app.FlutterFragmentActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import android.os.Environment; 


public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "cy.samples.flutter/battery";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                      if (call.method.equals("getBatteryLevel")) {
                        int batteryLevel = getBatteryLevel();
                
                        if (batteryLevel != -1) {
                            result.success(batteryLevel);
                        } else {
                            result.error("UNAVAILABLE", "Battery level not available.", null);
                        }
                    }else if (call.method.equals("getBasePath")) {
                      String path = getBasePath();
                     
                      if (path != null) {
                        result.success(path);
                      } else {
                        result.error("UNAVAILABLE", "获取路径失败", null);
                      }
                    } else {
                        result.notImplemented();
                    }
                    }
                });
   
  }

  private int getBatteryLevel() {
    int batteryLevel = -1;
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
      batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
    } else {
      Intent intent = new ContextWrapper(getApplicationContext()).
          registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
      batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
          intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
    }
  
    return batteryLevel;
  }

  public String getSDPath(){ 
    String sdcard = Environment.getExternalStorageState(); 
    if(sdcard.equals(Environment.MEDIA_MOUNTED)){ 
      return Environment.getExternalStorageDirectory().getAbsolutePath(); 
    }else{ 
      return null; 
    } 
  } 

  private String getBasePath() {
    String basePath = getSDPath(); 
    if(basePath==null){ 
      return Environment.getDataDirectory().getAbsolutePath(); 
    }else{ 
      return basePath; 
    } 
  }
}
