# One Dose Health

- Get URL : https://apitest1.onedosehealth.com/api/v1/Measurement/get-bmi-measurements
- Insert URL : https://apitest1.onedosehealth.com/api/v1/Measurement/add-bmi-with-detail

- Api'ye kayıt işlemi sırasında gönderilecek modelin içerisine Helath verisi ise "isFromHealth" : true şeklinde gönderilmeli ve gelen api list içerisinde "isFromHealth" prop'u olmalı
- Api'ye kayıt işlemi sırasında gönderilecek modelin içerisine "device" prop'u eklenmeli. Aşağıdaki json formatında olmalı ve gelen api list içerisinde yer almalı

    ...
    "device": {
        "deviceId" : (String),
        "manufacturerName" : (String),
        "modelName" : (String),
        "serialNumber" : (String),
        "deviceType" : (Enum) -> (accuChek, contourPlusOne, omronBloodPressureArm, omronBloodPressureWrist, omronScale, miScale, manuel),
    }
    ...
