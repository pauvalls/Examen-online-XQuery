xquery version "3.0";

declare option exist:serialize "method=html5 media-type=text/html";

<html>
    <head>
        <title>Resultat</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="css/styles.css" rel="stylesheet" type="text/css" />
  
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <!--<script src="js/scripts.js" type="text/javascript"/>-->
        <script src="js/bootstrap.min.js" type="text/javascript"/>
    </head>
    
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 main-header" style="text-align: center;">
                    <h1>EXAMEN #32543657</h1>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-4">
                </div>
                <div class="col-md-4 main-content">
                    <!--{
                        for $parameter in request:get-parameter-names()
                        let $answer := doc('./test/sample_1.xml')/preguntes/pregunta[@id=$parameter]/resposta
                        return <div><b>{$parameter}</b> - {request:get-parameter($parameter, '')} - {$answer}</div>
                    }-->
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Pregunta</th>
                                <th>Resultat</th>
                            </tr>
                        </thead>
                        <tbody>
                    {
                        for $parameter in request:get-parameter-names()
                        let $answer := doc('./test/sample_1.xml')/preguntes/pregunta[@id=$parameter]
                        return 
                            if (request:get-parameter($parameter, '') = $answer/resposta) then (
                            <tr class="success"><td>{$answer/text}</td><td>Correcte <span class="glyphicon glyphicon-ok" style="margin-left: 8px;"></span></td></tr>
                        ) else (
                            <tr class="danger"><td>{$answer/text}</td><td>Incorrecte <span class="glyphicon glyphicon-remove" style="margin-left: 8px;"></span></td></tr>
                        )
                    }
                    </tbody>
                    </table>
                    <div class="final-mark">
                    {
                        let $correct :=
                            for $parameter in request:get-parameter-names()
                            let $answer := request:get-parameter($parameter, '')
                            where doc('./test/sample_1.xml')/preguntes/pregunta[@id=$parameter]/resposta = $answer
                            return request:get-parameter($parameter, '')
                        
                        let $c := count($correct)
                        return <span>Nota: {$c} / 10</span>
                    }
                    </div>
                    <a href="index.xql" class="btn btn-primary btn-block">Realizar el examen de nuevo</a>
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