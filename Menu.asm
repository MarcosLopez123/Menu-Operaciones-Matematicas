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
        ;Macro 3
        LeerNumeros Macro
            Imprimir Mensaje9       ;Imprime el contenido del mensaje 7
            Call Leer                
            SUB AL, 30H             ; RESTAR 30H/48D 
            mov dece, al
            Call Leer               
            SUB AL, 30H             ; RESTAR 30H/48D 
            mov uni, al
            mov al,dece
            mov bl,10
            mul bl
            add al,uni
            mov N1,al
            Imprimir Mensaje10       ;Imprime el contenido del mensaje 7
            Call Leer               
            SUB AL, 30H             ; RESTAR 30H/48D 
            mov dece, al
            Call Leer             
            SUB AL, 30H             ; RESTAR 30H/48D 
            mov uni, al
            mov al,dece
            mov bl,10
            mul bl
            add al,uni
            mov N2,al  
        endm 
        SALTO PROC NEAR
            MOV AH,09H
            LEA DX,LINEA
            INT 21H                  ;llamamos interrupcion 21h
            MOV DL,00H
            RET
            SALTO ENDP 
        leernum macro
           mov ah,01h     ;Function(character read) Guarda en AL
           int 21h        ;Interruption DOS functions
           sub al,30h     ;ajustamos valores
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
            Multiplicacion: 
           Imprimir Mensaje9
           leernum
           mov mil,al    ;[mil].cen * dece = ac.N1.N2
           leernum
           mov cen,al    ;mil.[cen] * dece = ac.N1.N2 
           Imprimir Mensaje10
           leernum   
           mov dece,al    ;mil.cen * [dece] = ac.N1.N2
           leernum
           mov uni,al    ;mil.cen * [dece] = ac.N1.N2
           ;Realizamos operacion   
          
           mov al,uni  ;unidad del segundo numero
           mov bl,cen  ;unidad del primer numero
           mul bl       ;multiplicar
           mov ah,0     ;limpiamos ah0
           aam          ;separamos de hex a dec
           mov ac1,ah   ;decenas del primera multiplicacion
           mov N4,al    ;unidades del primera multiplicacion
                    
           mov al,uni  ;unidades del segundo numero
           mov bl,mil  ;decentas del primer numero
           mul bl       ;multiplicar
           mov N3,al    ;movemos el resultado de la operacion a N3
           mov bl,ac1   ;movemos el acarreo a bl
           add N3,bl    ;sumamos resultado mas acarreo
           mov ah,00h   ;limpiamos ah por residuos
           mov al,N3    ;movemos el resultado de la suma a al
           aam          ;separamos  de hex a dec
           mov N3,al    ;guardamos unidades en N3
           mov ac1,ah   ;guardamos decenas en ac1
        
           mov al,dece    ;al = dece
           mov bl,cen    ;bl = cen
           mul bl         ;AL = dece*cen (BL*AL)
           mov Ah,0h      ;
           AAM            ;ASCII Adjusment
           mov ac,AH      ;ac = AH (Acarreo)
           mov N2,AL      ;N2 = AL       (Unidad del resultado)
        
           mov al,dece    ;AL = dece
           mov bl,mil    ;BL = mil
           mul bl         ;AL = mil*dece (BL*AL)
           mov N1,al      ;N1 = AL       (Decena del resultado)
           mov bl,ac      ;BL = Acarreo anterior
           add N1,bl      ;N1 = N1+ac (N1 + Acarreo)
           mov ah,00h     ;
           mov al,N1      ;AL = N1 (Asignacion para el ajust)
           AAM            ;ASCII Adjustment
           mov N1,al      ;N1 = AL
           mov ac,ah      ;ac = AH (Acarreo para la Centena del resultado)   
           ;suma final
           ;R4 resulta ser las unidades de mul y no se toma en cuenta ya que se pasa entero
           mov ax,0000h   ;limpiamos ax
           mov al,N3      ;movemos el segundo resultado de la primera mult a al
           mov bl,N2      ;movemos primer resultado de la segunda mult a bl
           add al,bl      ;sumamos
           mov ah,00h     ;limpiamos ah
           aam            ;separamos hex a dec
           mov N3,al      ;N3 guarda las decenas del resultado final
           mov N2,ah      ;N2 se utiliza como nuevo acarreo
           mov ax,0000h   ;''''
           mov al,ac1     ;movemos el acarreo de la primera mult a al
           mov bl,N1      ;movemos segundo resultado de la segunda mult a bl
           add al,N2      ;sumamos el nuevo  acarreo de la suma anterior  a al
           add al,bl      ;sumamos al a bl
           mov ah,00h     ;limpiamos el registro ah
           aam            ;separamos de hex a dec
           mov N1,al      ;N1 guarda las centenas
           mov N2,ah      ;ah se sigue utilizando como acarreo
           mov al,N2      ;movemos el acarreo a al
           mov bl,ac      ;movemos ac a bl
           add al,bl      ;sumamos al a bl
           mov ac,al      ;mov al a ac como nuestro acarreo final
           Imprimir Mensaje8
           ;Mostramos resultado
           mov ah,02h 
           mov dl,ac
           add dl,30h
           int 21h        ;Mostramos ac (millar)
           mov ah,02H
           mov dl,N1
           add dl,30h
           int 21h        ;Mostramos N1 (centena)
           mov ah,02H
           mov dl,N3
           add dl,30h
           int 21h        ;Mostramos N3 (decena)
           mov ah,02H
           mov dl,N4
           add dl,30h
           int 21h        ;Mostramos unidades
           Call salto
           jmp Menuprincipal   ; regresa al menu principal
        
        Division:
            Imprimir msg        ; llama al msg y lo muestra en pantalla
            LeerNumeros         ; llama al mensaje LeerNumeros y lo muestra en pantalla
            
            xor ax, ax    ;Limpia el registro ax, esto es para que no ocurra errores en la division
            mov al, N1
            mov bl, N2 
            div bl
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
            jmp Menuprincipal     ; regresa al menu principal                                                                                                           
        salir:                 ;Cuando se presione la tecla enter se pasa a este metodo
            MOV AH, 4cH        ;Servicio de salida o finalizacion del programa
            INT 21H          

        end                    ;Fin del programa       
ret        