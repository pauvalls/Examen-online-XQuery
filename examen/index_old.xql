xquery version "3.0";

declare option exist:serialize "method=html5 media-type=text/html";

<html>
    <head>
        <title>Examen</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="css/styles.css" rel="stylesheet" type="text/css" />
  
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="js/scripts.js" type="text/javascript"/>
        <script src="js/bootstrap.min.js" type="text/javascript"/>
    </head>
    
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 main-header">
                    <h1>EXAMEN #32543657</h1>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-4">
                    <div class="row">
                        <div class="col-md-5">
                        </div>
                        <div class="col-md-5 info-title">
                            TEMPS RESTANT<br/>
                            <span class="info-data" id="chronometer">--:--</span>
                        </div>
                        <div class="col-md-1">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-5">
                        </div>
                        <div class="col-md-5 info-title">
                            INTENTS RESTANTS<br/>
                            <span class="info-data" id="tries">--</span>
                        </div>
                        <div class="col-md-1">
                        </div>
                    </div>
                </div>
                <div class="col-md-4 main-content">
                    <form id="examForm" method="POST" action="correction.xql">
                        {
                            for $question in doc('/db/apps/examen/test/sample_1.xml')/preguntes/pregunta
                            return if($question/@tipus="text") then (
                                <div class="form-group"><label for="{$question/@id}">{$question/text}</label><br/><input type="text" class="form-control" name="{$question/@id}" id="{$question/@id}" placeholder="Escriu la resposta"/></div>
                            ) else if($question/@tipus="select") then (
                                <div class="form-group"><label for="{$question/@id}">{$question/text}</label><br/><select class="form-control" name="{$question/@id}" id="{$question/@id}">
                                {
                                    for $option at $x in $question/opcio
                                    return <option value="{$x - 1}">{$option}</option>
                                }
                                </select></div>
                            ) else if($question/@tipus="radio") then (
                                <div class="form-group"><b>{$question/text}</b>
                                {
                                    for $option at $x in $question/opcio
                                    return <div class="radio">
                                    <label><input type="radio" name="{$question/@id}" value="{$x - 1}" />{$option}</label></div>
                                }</div>
                            ) else ()
                        }
                        <div class="alert alert-info">
                            <span class="glyphicon glyphicon-info-sign" style="margin-right: 8px;"></span><strong>Informació:</strong> Recorda que per a poder corregir l'examen s'hauran d'haver contestat totes les preguntes proposades.
                        </div>
                        <input type="submit" value="Corregir" class="btn btn-primary btn-block"/>
                    </form>
                </div>
                <div class="col-md-4">
                </div>
            </div>
                
            <div class="row">
                <div class="col-md-12 main-footer">
                    Todos los derechos reservados.
                </div>
            </div>
        </div>
    </body>
    
</html>