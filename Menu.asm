;INSTITUTO TECNOLOGICO SUPERIOR DE VALLADOLID.  
;MATERIA: LENGUAJES Y AUTOMATAS.
;DOCENTE: JOSE LEONEL PECH MAY.
;ALUMNOS : MARCOS CALVARIO LOPEZ - LILI MERCEDES DIAZ CUPUL.  
;6 SEMESTRE GRUPO A.
;EJERCICIO PROGRAMA INFORMATICO MENU DE OPERACIONES MATEMATICAS. 
;FECHA DE ENTREGA: 01/06/2020
org 100h        ; Origen,  indica que comience el programa
.Model small; Tamanio del programa 
.data   ; Declaramos las variables que vamos a utilizar en nuestro codigo    
        msg db 10,13, "El primer numero a ingresar debe ser el mayor"     
        Mensaje1  db 10,13, "Menu de operaciones matematicas    $"    ; estos son mensajes que apareceran en el menu para el usuario
        Mensaje2  db 10,13, "1.- Suma $"                               ; estos son mensajes que apareceran en el menu para el usuario
        Mensaje3  db 10,13, "2.- Resta $"                              ; estos son mensajes que apareceran en el menu para el usuario
        Mensaje4  db 10,13, "3.- Multiplicacion $"                      ; estos son mensajes que apareceran en el menu para el usuario
        Mensaje5  db 10,13, "4.- Division $"                            ; estos son mensajes que apareceran en el menu para el usuario
        Mensaje6  db 10,13, "5.- Salir $"                                ; estos son mensajes que apareceran en el menu para el usuario
        Mensaje7  db 10,13, "Eliga su opcion $"                          ; estos son mensajes que apareceran en el menu para el usuario
        Mensaje8  db 10,13, "El resultado es:  $"                         ; estos son mensajes que apareceran en el menu para el usuario
        Mensaje9 db 10,13,  "Dame el primer numero Ejemplo 02,15 :  $"    ; estos son mensajes que apareceran en el menu para el usuario
        Mensaje10 db 10,13, "Dame el segundo numero Ejemplo 02,15 :  $"   ; estos son mensajes que apareceran en el menu para el usuario
        Mensaje11 db 10,13, "Opcion invalida  $"                          ; estos son mensajes que apareceran en el menu para el usuario
        LINEA DB     13,10, '$'                                           ; estos son mensajes que apareceran en el menu para el usuario
        mil   db     0   ; declaramos nuestra variable de milesimas
        cen   db     0   ; declaramos nuestra variable de centenas
        dece  db     0   ; declaramos nuestra variable de decenas
        uni   db     0   ; declaramos nuestra variable de unidades
        N1    db     0
        N2    db     0  
        N3    db     0  
        N4    db     0
        ac    db     0 ;acarreo
        ac1   db     0   


;-------------------------------------------MACROS Y PROCEDIMIENTOS----------------------------------
        ;Macro1       
        Imprimir Macro mensaje        ; Imprimimos el mensaje de macro , iniciamos macro
            mov dx, offset mensaje    ; mandamos el valor del msj a dx
        	mov ah, 9h                ; Sirve para la impresion de los mensajes
        	int 21h                   ; Interrupcion para que se muestre el msj en pantalla
        endm                          ;finaliza el macro
        ;Procedimiento1
        LEER PROC NEAR                ; iniciamos nuestro procedimiento near
            MOV AH,01H                ;leer caracter desde el teclado
            INT 21H                   ;lee primer caracter     
            RET 
        LEER ENDP                     ;finalizamos nuestro procedimiento
        ;Macro 2
        Resultado Macro                 ; Imprimimos el mensaje de macro , iniciamos macro
        Imprimir Mensaje8
            mov ah,02h                  ; mandamos la interrupcion 02h
            mov dl,cen                  ;mandamos centenas a dl
            add dl,30h            ; se suma 30h a dl para imprimir el numero real.
            int 21h                ;llamamos interrupcion 21h
            mov dl,dece
            add dl,30h
            int 21h                ;llamamos interrupcion 21h
            mov dl,uni
            add dl,30h
            int 21h                ;llamamos interrupcion 21h
        endm 


;---------------------------------------------------------------------------------------------       
.code
main:
        mov ax, @data       ;Pone en direccion a AX
        mov ds, ax          ;Se envia los registros que tiene AX a DS  
        Menuprincipal:      ;creamos nuestro metodo
            Imprimir Mensaje1       ;Imprime el contenido del mensaje 1 
            Imprimir Mensaje2       ;Imprime el contenido del mensaje 2
            Imprimir Mensaje3       ;Imprime el contenido del mensaje 3 
            Imprimir Mensaje4       ;Imprime el contenido del mensaje 4
            Imprimir Mensaje5       ;Imprime el contenido del mensaje 5
            Imprimir Mensaje6       ;Imprime el contenido del mensaje 6
            Imprimir Mensaje7       ;Imprime el contenido del mensaje 7
            Call Leer               ;llama a leer
            cmp al, "1"             ;Compara e indica cual es la opcion 1
            je Suma                 ; lo manda a la suma
            cmp al, "2"             ;Compara e indica cual es la opcion 2
            je Resta                ;envia a resta
            cmp al, "3"             ;Compara e indica cual es la opcion 3
            je Multiplicacion       ; envia a multiplicacion
            cmp al, "4"             ; Compara e indica cual es la opcion 4
            je Division             ;envia a division
            cmp al, "5"             ;Compara e indica cual es la opcion 5
            je Salir                ;envia a la opcion salir 
         
        Suma:                        ; proceso de la suma
            LeerNumeros              ; llama la macro
            mov al, N1                ;envia el valor que toma N1 a al
            add al, N2                ;envia el valor que toma N2 a al
            mov N3, al               ; mueve lo que tiene al a N3
            mov al,N3 ; asigno un valor de 3 digitos en decimal al registro AL
            aam ;ajusta el valor en AL por: AH=23 Y AL=4
            mov uni,al ; Respaldo 4 en unidades
            mov al,ah  ;muevo lo que tengo en AH a AL para poder volver a separar los numeros
            aam         ; separa lo qe hay en AL por: AH=2 Y AL=3
            mov cen,ah ;respaldo las centenas en cen en este caso 2
            mov dece,al ;respaldo las decenas en dec, en este caso 3
            Resultado                 ; llama a resutado
            Call salto                
            jmp Menuprincipal          ;regresa al menu principal
        
        Resta:
            LeerNumeros 
            mov al, N1
            sub al, N2
            mov N3, al  
            mov al,N3 ; asigno un valor de 3 digitos en decimal al registro AL
            aam ;ajusta el valor en AL por: AH=23 Y AL=4
            mov uni,al ; Respaldo 4 en unidades
            mov al,ah  ;muevo lo que tengo en AH a AL para poder volver a separar los numeros
            aam         ; separa lo qe hay en AL por: AH=2 Y AL=3
            mov cen,ah ;respaldo las centenas en cen en este caso 2
            mov dece,al ;respaldo las decenas en dec, en este caso 3
            Resultado
            Call salto
            jmp Menuprincipal   