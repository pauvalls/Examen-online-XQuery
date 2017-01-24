
window.onload = function() {
    var form = document.getElementById("examForm");
    var chrono = document.getElementById("chronometer");
    var tries = document.getElementById("tries");
    
    var remTries = getRemainingTries();
    if (parseInt(remTries, 10) > 0) {
        tries.innerHTML = padNum(remTries);
        
        form.onsubmit = function() {
            for (i = 0; i < form.elements.length; i++) {
                var type = form.elements[i].type;
                switch (type) {
                    case "text":
                        if (form.elements[i].value === "") {
                            alert("Debes rellenar todos los campos.");
                            form.elements[i].focus();
                            return false;
                        }
                        break;
                    default:
                        // Nothing to do here. Nunca debería darse este caso
                        break;
                }
            }
            consumeTry();
        };
        
        var time = 600;
        chrono.innerHTML = formatTime(time);
        var countdown = setInterval(function() {
            time--;
            chrono.innerHTML = formatTime(time);
            if (time < 0 || time === 0) {
                clearInterval(countdown);
                alert("Time's over");
                consumeTry();
                window.location.href = "timeover.html";
            }
        }, 1000);
    } else {
        alert("No quedan intentos.");
        // Gestionar cuando no quedan intentos.
        window.location.href = "triesover.html";
    }
};

function getRemainingTries() {
    var t;
    if (typeof(Storage) !== "undefined") {
        t = localStorage.getItem("remainingTries");
        if (t === null) {
            t = 3;
            localStorage.setItem("remainingTries", t);
        }
        return t;
    } else {
        document.getElementById("result").innerHTML = "Sorry, your browser does not support Web Storage...";
    }
}

function consumeTry() {
    var t = localStorage.getItem("remainingTries");
    localStorage.setItem("remainingTries", parseInt(t, 10) - 1);
}

function formatTime(t) {
    var minutes;
    var seconds;
    if (t > 60) {
        minutes = padNum(Math.floor(t / 60));
        seconds = padNum(t - (minutes * 60));
    } else {
        minutes = "00";
        seconds = padNum(t);
    }
    return minutes + ":" + seconds;
}

function padNum(num) {
    var t = "";
    if (num < 10) {
        t = "0" + num;
    } else {
        t = num;
    }
    return t;
}


