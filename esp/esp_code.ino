#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <Firebase_ESP_Client.h>

// Provide the token generation process info.
#include "addons/TokenHelper.h"
// Provide the RTDB payload printing info and other helper functions.
#include "addons/RTDBHelper.h"

// Insert your network credentials
#define WIFI_SSID "NETWORK SSID"
#define WIFI_PASSWORD "NETWORK PASSWORD"

// Insert Firebase project API Key
// #define API_KEY "AIzaSyDiGnLUPo61bKrSmCCfUuIixvuxaevbnek" // old project
#define API_KEY "AIzaSyDN7LeGinn2jiAVJsaBcKrBqDdcXK7zIas"

// Insert RTDB URLefine the RTDB URL
// #define DATABASE_URL "https://testproject-54d36-default-rtdb.firebaseio.com/" //old project
#define DATABASE_URL "https://clogdetectiondatabase-default-rtdb.firebaseio.com/"

// Define output pins
#define ALTERNATE_ROUTE D0

// Define Firebase Data object
FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;

// set up ng sensors
const int flow_sensor1 = D1;
volatile long pulse1;

const int flow_sensor2 = D2;
volatile long pulse2;

const int flow_sensor3 = D3;
volatile long pulse3;

unsigned long lastTime = 0.0;

double reading1 = 10.0;
double reading2 = 11.0;
double reading3 = 12.0;

// pangdertermine kung saan ang clog
int r1order = 0;
bool r1orderRecorded = false;
int r2order = 0;
bool r2orderRecorded = false;
int r3order = 0;
bool r3orderRecorded = false;

int orderRef = 1;

bool signupOK = false;

void setup()
{
    // pinmode initialization
    pinMode(ALTERNATE_ROUTE, OUTPUT);
    pinMode(flow_sensor1, INPUT);
    pinMode(flow_sensor2, INPUT);
    pinMode(flow_sensor3, INPUT);

    Serial.begin(9600);

    attachInterrupt(digitalPinToInterrupt(flow_sensor1), increase1, RISING);
    attachInterrupt(digitalPinToInterrupt(flow_sensor2), increase2, RISING);
    attachInterrupt(digitalPinToInterrupt(flow_sensor3), increase3, RISING);

    WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
    Serial.print("Connecting to Wi-Fi");
    while (WiFi.status() != WL_CONNECTED)
    {
        Serial.print(".");
        delay(300);
    }
    Serial.println();
    Serial.print("Connected with IP: ");
    Serial.println(WiFi.localIP());
    Serial.println();

    // database setup
    config.api_key = API_KEY;
    config.database_url = DATABASE_URL;
    if (Firebase.signUp(&config, &auth, "", ""))
    {
        Serial.println("ok");
        signupOK = true;
    }
    else
    {
        Serial.printf("%s\n", config.signer.signupError.message.c_str());
    }

    // Assign the callback function for the long running token generation task
    config.token_status_callback = tokenStatusCallback; // see addons/TokenHelper.h

    Firebase.begin(&config, &auth);
    Firebase.reconnectWiFi(true);
}

void loop()
{

    reading1 = 2.663 * pulse1;
    reading2 = 2.663 * pulse2;
    reading3 = 2.663 * pulse3;

    if (millis() - lastTime > 1000)
    {
        pulse1 = 0;
        pulse2 = 0;
        pulse3 = 0;
        lastTime = millis();
    }

    // pang determine san banda clog
    if (reading1 < 1)
    {
        if (!r1orderRecorded)
        {
            r1order = orderRef;
            orderRef += 1;
            r1orderRecorded = true;
        }
    }
    else
    {
        r1orderRecorded = false;
    }

    if (reading2 < 1)
    {
        if (!r2orderRecorded)
        {
            r2order = orderRef;
            orderRef += 1;
            r2orderRecorded = true;
        }
    }
    else
    {
        r2orderRecorded = false;
    }

    if (reading3 < 1)
    {
        if (!r3orderRecorded)
        {
            r3order = orderRef;
            orderRef += 1;
            r3orderRecorded = true;
        }
    }
    else
    {
        r3orderRecorded = false;
    }
    Serial.println(reading1);

    //&& (millis() - sendDataPrevMillis > 9600 || sendDataPrevMillis == 0) dagdag sa condition sa babab
    if (Firebase.ready() && signupOK)
    {

        // turn on alternate route if readings are 0
        if ((reading1 < 1) && (reading2 < 1) && (reading3 < 1))
        {
            if (Firebase.RTDB.setBool(&fbdo, "/alternateRoute/isClogged", true))
            {
                Serial.println("Turned on alternate route");
            }
        }

        // upload the readings to firebase database
        String values = "";
        values += reading1;
        values += "^";
        values += reading2;
        values += "^";
        values += reading3;
        values += "^";
        values += r1order;
        values += "^";
        values += r2order;
        values += "^";
        values += r3order;
        if (Firebase.RTDB.setString(&fbdo, "sensors/reading", values))
        {
            Serial.println("Uploaded to database");
        }
        else
        {
            Serial.println("FAIALTERNATE_ROUTE");
            Serial.println("REASON: " + fbdo.errorReason());
        }

        // Check alternate route and sync status to database
        if (Firebase.RTDB.getBool(&fbdo, "/alternateRoute/isClogged"))
        {
            bool result = fbdo.boolData();
            Serial.println(result);
            if (result)
            {
                digitalWrite(ALTERNATE_ROUTE, HIGH);
            }
            else
            {
                digitalWrite(ALTERNATE_ROUTE, LOW);
            }
        }
        else
        {
            Serial.println(fbdo.errorReason());
        }
    }

    if (orderRef > 3)
    {
        orderRef = 1;
    }
}

ICACHE_RAM_ATTR void increase1()
{
    pulse1++;
}
ICACHE_RAM_ATTR void increase2()
{
    pulse2++;
}
ICACHE_RAM_ATTR void increase3()
{
    pulse3++;
}