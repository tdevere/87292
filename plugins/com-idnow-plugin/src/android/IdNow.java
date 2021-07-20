package com.example;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;
import android.content.Context;
import android.content.Intent;
import android.webkit.WebSettings;
import android.widget.Toast;
import de.idnow.sdk.IDnowSDK;
import de.idnow.*;
import android.util.Log;

public class IdNow extends CordovaPlugin {
    private String companyId = "";
    private boolean showVideoOverviewCheck;
    private boolean showErrorSuccessScreen;
    private boolean appGoogleRating;
    private String language = "en";
    private boolean isTestEnvironment;
    private PluginResult pluginResult;
    private CallbackContext callbackContext;
    private final static String CANCELED_BY_USER = "canceled by user";


    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        this.callbackContext = callbackContext;
        cordova.setActivityResultCallback(this);
        pluginResult = new PluginResult(PluginResult.Status.OK, "success");
        pluginResult.setKeepCallback(true);
        if ("show".equals(action)) {
            show(args.getString(0), callbackContext);
            return true;
        } else if("setCompanyId".equals(action)) {
            setCompanyId(args.getString(0));
        } else if("setShowVideoOverviewCheck".equals(action)) {
            boolean showVideoOverview = args.getBoolean(0);
            setShowVideoOverviewCheck(showVideoOverview);
        } else if("setShowErrorSuccessScreen".equals(action)) {
            boolean showErrorSuccess = args.getBoolean(0);
            setShowErrorSuccessScreen(showErrorSuccess);
        } else if("setAppGoogleRating".equals(action)) {
            boolean appGoogleRating = args.getBoolean(0);
            setAppGoogleRating(appGoogleRating);
        } else if("startIdNowSdk".equals(action)) {
            String token = args.getString(0);
            startIdNowSdk(token);
            return true;
        } else if("isTestEnvironment".equals(action)) {
            boolean isTestEnvironment = args.getBoolean(0);
            isTestEnvironment(isTestEnvironment);
        } else if("setIdNowLanguage".equals((action))) {
            String language = args.getString(0);
            setIdNowLanguage(language);
        }

        return false;
    }

    private void show(String msg, CallbackContext callbackContext) {
        if (msg == null || msg.length() == 0) {
            callbackContext.error("Empty message!");
        } else {
            Toast.makeText(webView.getContext(), msg, Toast.LENGTH_LONG).show();
            callbackContext.success(msg);
        }
    }

    public void startIdNowSdk(String token) {
        Context context = this.cordova.getActivity();
        try {
            IDnowSDK.getInstance().initialize(cordova.getActivity(), companyId);
            IDnowSDK.setShowVideoOverviewCheck( showVideoOverviewCheck, context );
            IDnowSDK.setShowErrorSuccessScreen(showErrorSuccessScreen, context);
            IDnowSDK.setApp_GoogleRating(appGoogleRating);
            IDnowSDK.setEnvironment(IDnowSDK.Server.LIVE);
            if (isTestEnvironment) {
                IDnowSDK.setEnvironment(IDnowSDK.Server.TEST);
            }
            IDnowSDK.getInstance().start(token);
            IDnowSDK.getInstance().getAppContext().setTheme(0);
        } catch (Exception e) {
            Log.d("", e.getLocalizedMessage());
        }
    }

    public void setIdNowLanguage(String language) {
        this.language = language;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    public void setShowVideoOverviewCheck(boolean showVideoOverviewCheck) {
        this.showVideoOverviewCheck = showVideoOverviewCheck;
    }

    public void setShowErrorSuccessScreen(boolean showErrorSuccessScreen) {
        this.showErrorSuccessScreen = showErrorSuccessScreen;
    }

    public void setAppGoogleRating(boolean appGoogleRating) {
        this.appGoogleRating = appGoogleRating;
    }

    public void isTestEnvironment(boolean isTestEnvironment) {
        this.isTestEnvironment = isTestEnvironment;
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent intent) {
        if (requestCode == IDnowSDK.REQUEST_ID_NOW_SDK) {
            switch (resultCode) {
                case IDnowSDK.RESULT_CODE_CANCEL:
                    pluginResult = new PluginResult(PluginResult.Status.OK, CANCELED_BY_USER);
                    pluginResult.setKeepCallback(true);
                    callbackContext.sendPluginResult(pluginResult);
                    break;
                case IDnowSDK.RESULT_CODE_SUCCESS:
                    pluginResult = new PluginResult(PluginResult.Status.OK);
                    pluginResult.setKeepCallback(true);
                    callbackContext.sendPluginResult(pluginResult);
                    break;
                case IDnowSDK.RESULT_CODE_FAILED:
                    if (intent != null) {
                        String errorMessage = intent.getStringExtra(IDnowSDK.RESULT_DATA_ERROR);
                        pluginResult = new PluginResult(PluginResult.Status.ERROR, errorMessage);
                        pluginResult.setKeepCallback(true);
                        callbackContext.sendPluginResult(pluginResult);
                    }
                    break;
            }
        }
    }
}