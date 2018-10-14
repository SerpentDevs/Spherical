<?php
    // Spherical. Created by Jake Gealer <jake@gealer.email> 2018.

    require("botdetect/simple-botdetect.php");
    // Requires the BotDetect library.

    $Captcha = new SimpleCaptcha("Spherical");
    echo $Captcha->Html();
    // Creates the CAPTCHA and echos it.
