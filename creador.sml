fun menu () =
    let
        val _ = print "Bienvenido al Creador de Gestión de Pulpería\n";
        val _ = print "1- Agregar nueva fruta\n";
        val _ = print "2- Limpiar catálogo\n";
        val _ = print "3- Salir\n";
        val _ =print "Elige una opción: ";
        val linea = TextIO.inputLine TextIO.stdIn;
        val opcion =
            case linea of
                 NONE => "Entrada incorrecta"
               | SOME texto => String.extract (texto, 0, SOME (size texto - 1))
    in
        if opcion = "1" then (print "Agregar\n"; menu())
    else if opcion = "2" then ( print "Limpiar\n"; menu())
    else if opcion = "3" then OS.Process.exit (OS.Process.success)
    else (print "Opción inválida\n"; menu())
    end;

menu ();
