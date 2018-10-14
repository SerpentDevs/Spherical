<?php
    // Spherical. Created by Jake Gealer <jake@gealer.email> 2018.

    require("botdetect/simple-botdetect.php");
    // Requires the BotDetect library.

    $input = $_GET['input'];
    $id = $_GET['id'];
    // Gets the input and the captcha ID.

    $Captcha = new SimpleCaptcha("Spherical");
    $isHuman = $Captcha->Validate($input, $id);
    // Validates the CAPTCHA.

    $response = array("success" => $isHuman);
    $json_response = json_encode($response);
    // Creates the JSON response.

    echo $json_response;
    // Echos the response.
