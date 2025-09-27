val frutas = ref ([] : (string * string * string * int * real) list);


fun menu () =
    let
        val _ = print "Bienvenido al Creador de Gestión de Pulpería\n"
        val _ = print "1- Agregar nueva fruta\n"
        val _ = print "2- Limpiar catálogo\n"
        val _ = print "3- Salir\n"
        val _ = print "Elige una opción: "
        val linea = TextIO.inputLine TextIO.stdIn
        val opcion =
            case linea of
                 NONE => ""
               | SOME texto => String.extract (texto, 0, SOME (String.size texto - 1))
    in
        if opcion = "1" then menuAgregar ()
        else if opcion = "2" then
            ( vaciarArchivo(); menu ()) (*arreglar eso*)
        else if opcion = "3" then OS.Process.exit (OS.Process.success)
        else (print "Opción inválida\n"; menu ())
    end

and menuAgregar () =
    let
        val _ = print "Ingrese el código de la fruta:  "
        val code =
            case TextIO.inputLine TextIO.stdIn of
                 NONE => "Entrada incorrecta"
               | SOME texto => String.extract (texto, 0, SOME (String.size texto - 1))

        val _ = print "Ingrese el nombre de la fruta:  "
        val nombre =
            case TextIO.inputLine TextIO.stdIn of
                 NONE => "Entrada incorrecta"
               | SOME texto => String.extract (texto, 0, SOME (String.size texto - 1))

        val _ = print "Ingrese la familia de la fruta:  "
        val familia =
            case TextIO.inputLine TextIO.stdIn of
                 NONE => "Entrada incorrecta"
               | SOME texto => String.extract (texto, 0, SOME (String.size texto - 1))

        val _ = print "Ingrese la cantidad vendida de la fruta:  "
        val cantidad =
            case TextIO.inputLine TextIO.stdIn of
                 NONE => 0
               | SOME texto =>
                   let
                       val s = String.extract (texto, 0, SOME (String.size texto - 1))
                   in
                       case Int.fromString s of
                            SOME x => x
                          | NONE => 0
                   end

        val _ = print "Ingrese el precio de la fruta:  "
        val precio =
            case TextIO.inputLine TextIO.stdIn of
                 NONE => 0.0
               | SOME texto =>
                   let
                       val s = String.extract (texto, 0, SOME (String.size texto - 1))
                   in
                       case Real.fromString s of
                            SOME x => x
                          | NONE => 0.0
                   end

        val _ = frutas := (code, nombre, familia, cantidad, precio) :: !frutas

        val _ =
            let
                val str = code ^ "," ^ nombre ^ "," ^ familia ^ "," ^
                          Int.toString cantidad ^ "," ^ Real.toString precio ^ "\n"
                val archivo = TextIO.openAppend "frutas.csv"
                val _ = TextIO.output (archivo, str)
                val _ = TextIO.closeOut archivo
            in
                print "Se ha guardado exitosamente\n"
            end
    in
      menu ()
    end
and vaciarArchivo () = 
  let
    val archivo = TextIO.openOut "frutas.csv"
    val _ = TextIO.output (archivo, "")
    val _ = TextIO.closeOut archivo
    val _ = print "Limpiado exitosamente\n"
  in 
    frutas := [];
    menu()
  end;

menu ();
