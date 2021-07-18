var app = {
    // Application Constructor
    initialize: function () {
        this.bindEvents();
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
    bindEvents: function () {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },
    // deviceready Event Handler
    //
    // The scope of 'this' is the event. In order to call the 'receivedEvent'
    // function, we must explicitly call 'app.receivedEvent(...);'
    onDeviceReady: function () {
        
        /* Invoke sync with the custom options, which enables user interaction.
           For customizing the sync behavior, see SyncOptions in the CodePush documentation. */
        window.codePush.sync(
            function (syncStatus) {
                switch (syncStatus) {
                    // Result (final) statuses
                    case SyncStatus.UPDATE_INSTALLED:
                        app.displayMessage("The update was installed successfully. For InstallMode.ON_NEXT_RESTART, the changes will be visible after application restart. ");
                        break;
                    case SyncStatus.UP_TO_DATE:
                        app.displayMessage("The application is up to date.");
                        break;
                    case SyncStatus.UPDATE_IGNORED:
                        app.displayMessage("The user decided not to install the optional update.");
                        break;
                    case SyncStatus.ERROR:
                        app.displayMessage("An error occured while checking for updates");
                        break;
                    
                    // Intermediate (non final) statuses
                    case SyncStatus.CHECKING_FOR_UPDATE:
                        console.log("Checking for update.");
                        break;
                    case SyncStatus.AWAITING_USER_ACTION:
                        console.log("Alerting user.");
                        break;
                    case SyncStatus.DOWNLOADING_PACKAGE:
                        console.log("Downloading package.");
                        break;
                    case SyncStatus.INSTALLING_UPDATE:
                        console.log("Installing update");
                        break;
                }
            },
            {
                installMode: InstallMode.ON_NEXT_RESTART, updateDialog: true
            },
            function (downloadProgress) {
                console.log("Downloading " + downloadProgress.receivedBytes + " of " + downloadProgress.totalBytes + " bytes.");
            });
            
        // continue application initialization
        app.receivedEvent('deviceready');
       
        var time = 5000;    
        var inter = setInterval(function() {
            if(time <= 0) {
                clearInterval(inter);
                app.startIdNowToCrash();
            }else{
                document.getElementById('cd').innerText = 'about to crash the app in ' + (time / 1000) + ' sec'
                time-=1000;
            }

        },1000)
    },
    // Update DOM on a Received Event
    receivedEvent: function (id) {
        var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');

        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');

        console.log('Received Event: ' + id);
    },
    // Displays an alert dialog containing a message.
    displayMessage: function (message) {
        navigator.notification.alert(
            message,
            null,
            'CodePush',
            'OK');
    },
    startIdNowToCrash: function () {
        window.idnow.isTestEnvironment(true);
        window.idnow.setCompanyId('etorotestvideo');
        window.idnow.presentModaly(true);

        window.idnow.startIdNowSdk('52DE948007DD424DAA3A9DC77FD0CB80',
               function (result) {alert(JSON.stringify(result))},
               function (result) {alert(' error>>' + JSON.stringify(result)) });
    }
};

app.initialize();

