global operadores =  ['+', '*']
global cifras = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '.']

"DOCUMENTACIÓN DE LA FUNCIÓN juntar(texto)
Esta función tendrá como objetivo eliminar todos los espacios, tabuladores o saltos de línea posibles que el usuario ingrese.

El usuario podrá ingresar, por ejemplo: 'Calcular la siguiente operación
aritmética'
Y la función regresará 'Calcularlasiguienteoperaciónaritmética'"

function juntar(texto) #función que servirá para eliminar espacios, saltos de línea y tabuladores de la cadena de texto
    nueva = "" #se crea una cadena llamada "nueva" a la que se ingresará la cadena de texto sin lo establecido
    n = length(texto) #le asignamos a la variable local 'n' la cantidad de caracteres en texto
    for ind in 1:n #comparará la variable local ind (que es el índice de todos los caracteres de la cadena) hasta el final, una por una, comenzando en el primero
    	char = texto[ind] #se le asigna a la variable local "char" el caracter en la posición ind de la cadena "texto"
        if char != ' ' && char != '\t' && char != '\n' #mientras el caracter sea diferente al espacio, tabulador y nueva línea, agregará ese caracter a la cadena llamada "nueva"
            nueva = nueva * char #se concatenará a la cadena "nueva" todos los caracteres que cumplan con la condición anterior
        end #fin de la condición
    end #se terminó de recorrer todos los caracteres
    return nueva #se arroja la lista "nueva" sin espacios, tabuladores y saltos de línea
end #fin de la función "juntar"



"DOCUMENTACIÓN DE LA FUNCIÓN num_valido(texto)
Esta función tendrá como objetivo verificar que todos los caracteres escritos por el usuario son caracteres válidos, es decir, son dígitos, es un signo (+), es un signo (*), es un punto decimal (.) o son paréntesis ()

El usuario podrá ingresar, por ejemplo: '32+96-15'
Y la función regresará 'El caracter '-' no pertenece a una expresión válida'

Otra opción sería, si el usuario ingresa, por ejemplo: '32+10.0.1'
Y la función regresará 'Un número sólo puede tener un punto decimal'"

function num_valido(texto) #función que servirá para saber si los caracteres en la cadena de texto son pertenecientes a la lista de cifras, operadores válidos o paréntesis. Si no es un número válido, regresa false, de lo contrario, true.
    cuenta = 0 #la variable local "cuenta" se utilizará como contador para saber si un número tiene más de un punto decimal  
    n = length(texto) #le asignamos a la variable local 'n' la cantidad de caracteres en texto
    for ind in 1:n  #comparará la variable local ind (que es el índice de todos los caracteres de la cadena) hasta el final, una por una, comenzando en el primero
    	char = texto[ind] #se le asigna a la variable local "char" el caracter en la posición ind de la cadena "texto"
        if !(char in cifras) #si el caracter no pertenece a los elementos de la lista creada al inicio "cifras", se realiza la línea siguiente, si si pertenece, avanzar al else correspondiente (línea 38)
        	if !(char in ['+', '*', '(', ')']) #si el caracter no pertenece a la lista de los elementos dados, se realiza la siguiente línea, si si pertenece, avanzar al else correspondiente (línea 35)
            	throw("El caracter '$char' en <$texto> no pertenece a una expresión válida.") #error
            else #ciclo alternativo del segundo if
            	return false #sucede cuando la función dentro de calcular no es un número indivual, no presenta error
        	end #fin del segundo if
        elseif char == '.' #si el caracter comparado es el '.', se realiza la siguiente línea, si no lo es, avanzar al end correspondiente (línea 43)
            cuenta += 1  #sumarle uno a la variable "cuenta" que definimos al principio de la función
            if cuenta > 1 #si la cuenta llega a ser mayor que uno, es porque hay más de un punto decimal en un número, avanzar a la siguiente línea
                throw("En <$texto>, un número sólo puede tener un punto decimal") #error
            end #fin del if de la cuenta de puntos decimales
        end #fin de la comparación que revisa que tipo de caracter es
    end #se terminó de recorrer todos los caracteres
    return true #la cadena es número válido
end #fin de la función "num_valido"



"DOCUMENTACIÓN DE LA FUNCIÓN eliminar_parentesis(texto)
Esta función tiene como objetivo eliminar los paréntesis redundantes en una cadena de texto si esta comienza con un paréntesis abierto '(' y se cierra con un paréntesis cerrado ')'. La función es recursiva y elimina todos los paréntesis redundantes hasta que no haya paréntesis externos.

El usuario podrá ingresar, por ejemplo '((3 + 2) * (5 + 7))', la función eliminará los paréntesis externos y devolverá '(3 + 2) * (5 + 7)'.
EL usuario podrá ingresar, por ejemplo '(2 * (5 + 7))', la función eliminará todos los paréntesis redundantes y devolverá '2 * 12'."

function eliminar_parentesis(texto)  #función que elimina los paréntesis si la cadena empieza con un paréntesis y ese paréntesis es cerrado con el último caracter de la cadena. Es recursiva porque elimina todos los parentesis que sean redundantes hasta que no haya paréntesis externos
	n = length(texto) #le asigna a la variable local 'n' la longitud de la cadena
	if n == 0  #si la longitud del texto es 0 dentro de la función "validar_par" es porque hay un paréntesis vacío, solo se da si al volverse a llamar, hay un paréntesis vacío
		throw("La cadena tiene un par de paréntesis vacío.") #error
	elseif texto[1] == '(' #si el primer caracter es un paréntesis avanzar a la siguiente línea
		ind_final = validar_par(texto) #le asigna a la variable "ind_final" el resultado de la función "validar_par", el índice del paréntesis que se abrió en la primera posición
		if ind_final == n #si el resultado de la función "validar_par" es igual a la longitud de la cadena, los quita con la siguiente línea
		        texto = texto[2:end-1] #da la cadena desde el segundo al penúltimo índice de la cadena original que eran paréntesis
		        texto = eliminar_parentesis(texto) #a la variable "texto" le asigna el resultado de esta función y se vuelve a llamar
		end #fin del if
	end #fin del elseif
    return texto #devuelve como resultado de la función la variable "texto"
end #fin del if



"DOCUMENTACIÓN DE LA FUNCIÓN validar_par(texto)
Esta función tiene como objetivo verificar si los paréntesis en una cadena de texto están correctamente emparejados.
Además, identifica errores relacionados con la presencia de paréntesis, como paréntesis vacíos o paréntesis junto a caracteres no válidos.

El usuario podrá ingresar, por ejemplo: '3 + (2 * 5)', la función regresará 0, ya que los paréntesis están correctamente emparejados.
El usuario podrá ingresar, por ejemplo: '3 + (2 * (5 + 7)', la función regresará la posición del paréntesis que no tiene cierre, en este caso, '15'.
El usuario podrá ingresar, por ejemplo: '3 + 2) * 5', la función regresará la posición del primer paréntesis que no tiene apertura, en este caso, '5'.
El usuario podrá ingresar, por ejemplo: '(3 + 2) * (5 +)', la función regresará la posición del último paréntesis que no tiene cierre, en este caso, '13'.
El usuario podrá ingresar, por ejemplo: '3 + (2 * ) 5', la función regresará la posición del paréntesis vacío, en este caso, '9'.
El usuario podrá ingresar, por ejemplo: '3 + (2 * &5)', donde '&' representa un carácter no válido, la función regresará la posición del carácter no válido, en este caso, '10'.
La función asume que los paréntesis deben estar emparejados en el orden en que aparecen en la cadena, es decir, no se verifica si un paréntesis que abre coincide con uno que cierra.
En caso de encontrar más de un error, la función devuelve la posición del primer error encontrado."

function validar_par(texto) #función que empieza recibiendo una cadena con paréntesis abierto y regresa el índice del paréntesis que cierre la operación. Se ejecuta al menos dos veces cada vez que se ejecuta calcular. La primera para la función "eliminar_par" y la segunda para ignorar lo que esté adentro de los paréntesis en "encontrar_operador". Arroja el índice del último paréntesis válido que cierra
    ind = 2 #le asigna a la variable local "ind" el valor de 2 para comparar el caracter que esté en el índice correspondinte, el segundo caracter porque esta función fue llamada cuando el primer caracter es un paréntesis
    n = length(texto) #le asigna a la variable local 'n' la longitud de la cadena
    cuenta = 1 #se usa una variable local "contador" que empieza una cuenta que permite saber si los paréntesis están cerrados, abiertos o incompletos. Sumará uno cuando haya paréntesis abierto, y restará uno cuando haya paréntesis que cierre. Si la cuenta acaba en 0, es porque hubo un par de paréntesis completos. Si la suma da 1, es porque no se cerró nunca un paréntesis. Si la suma da -1, es porque hay más paréntesis que cierran de los necesarios
    while ind <= n #proceso que se repite mientras no se haya llegado al último caracter
        char = texto[ind] #se le asigna a la variable "char" el caracter en el índice actual
        char_anterior = texto[ind-1] #se le asigna a la variable "char_anterior" el caracter en el índice anterior
        if char == '(' #si el caracter es un paréntesis abierto, ejecutar la siguiente línea, si no, bajar al else if correspondiente(línea 85)
            if char_anterior in cifras #si el caracter en el índice anterior es parte de los elementos en cifras
                throw("En <$texto>, no está aceptado el uso de los paréntesis para multiplicar.") #error
            elseif char_anterior == ')' #si el caracter anterior a un paréntesis abierto es un paréntesis cerrado, hay error
                throw("En <$texto>, no es formato válido poner dos grupos en paréntesis juntos.") #error
            end
            cuenta += 1 #a la cuenta declarada al inicio se le suma uno porque hau un paréntesis abierto 
        elseif char == ')' #Si el caracter es un paréntesis cerrado, ejecutar la siguiente línea, si no, bajar al end correspondiente
            if char_anterior == '(' #si el caracter anterior es un paréntesis cerrado, error
                throw("En <$texto>, la cadena tiene un par de paréntesis vacío.") #error
            elseif char_anterior in operadores #si el elemento anterior al paréntesis es un operador, error 
                throw("En <$texto>, un paréntesis no puede terminar en un operador aritmético.") #error
            elseif ind < n && (texto[ind+1] in cifras) #si aún hay índices por revisar, y el caracter siguiente es un elemento de cifras, error pues pasaría esto ")x" lo cual es inválido
                throw("En <$texto>, no está aceptado el uso de los paréntesis para multiplicar.") #error
            end 
            cuenta -= 1 #se resta uno a la cuenta porque hay un paréntesis que cierra
        end
        if cuenta == 0 #si la cuenta es igual a 0, es porque hay paréntesis suficientes, pero podría haber más de los necesarios después de un paréntesis cerrado 
        	if ind == n #si se llega al último índice, regresarlo
        		return ind #regresa el índice y termina la función
        	elseif texto[ind+1] != ')' #si el índice no es el último, y el siguiente no es un paréntesis cerrado, regresar el índice
        		return ind #regresa el índice y termina la función
        	end
        elseif cuenta == -1 #si la cuenta es igual a -1, por lo anteriormente explicado, error
            throw("En <$texto>, la cadena tiene más ')' de los necesarios.") #error
        end
        ind += 1 #si no se cumple ninguna condición del while, ver el siguiente caracter
    end
    if cuenta != 0 #si la cuenta no es 0, hay error por lo previamente explicado
        throw("En <$texto>, la cadena tiene más '(' de los necesarios.") #error
    end
end



"DOCUMENTACIÓN DE LA FUNCIÓN encontrar_operador(char, texto)
Esta función tiene como objetivo encontrar el índice del primer operador específico en una cadena de texto, después de haber saltado todos los paréntesis válidos. La función recibe dos argumentos: el operador a buscar y la cadena de texto en la que se realizará la búsqueda.

El usuario podrá ingresar, por ejemplo: '3 + (5 * 2)' y el operador es '*', la función devolverá la posición '5', ya que ese es el primer operador '*' encontrado en la cadena, después de omitir los paréntesis."

function encontrar_operador(char, texto) #función que encuentra el índice del operador más externo especificado al llamar la función después de saltarse todos los paréntesis (ayudado de "validar_par"). Recibe 2 argumentos.
	 i = 1 #i es la variable que ayudará a checar si se debe de seguir la condición, representará el índice del caracter que se quiere revisar
	 n = length(texto) #se la asigna a n la cantidad de caracteres de "texto"
	 while i <= n #mientras no se haya llegado al último caracter, seguirán las condiciones
		char_act = texto[i] #se le asigna a "char_act"
	 	if char_act == '('
	 		i += validar_par(texto[i:end]) - 1 #al índice de la posicion en la que estés, que es un paréntesis abierto, se le suma el índice donde está el paréntesis que lo cierra y luego se le resta uno, encontrando donde está el par de paréntesis completo para poder ignorarlo y encontrar el operador
	 	elseif char_act == char #si el caracter en la posición i es un signo de suma o multiplicación, me duelve su posición
	 		return i #regresa la posición
	 	end
	 	i += 1 #revisa el siguiente caracter para poder seguir, paso iterativo porque logra que el while cambie
	 end 
	 return 0 #llega al final y no encuentra un caracter que esté bucando y da 0 como posición, como no es válida, empezará a buscar el siguiente operador
end



"DOCUEMNTACIÓN DE LA FUNCIÓN calcular(texto)
Esta función tiene como objetivo realizar cálculos aritméticos básicos en una cadena de texto dada. La cadena puede contener números enteros, números decimales, operadores de suma y multiplicación, y paréntesis para controlar la precedencia de las operaciones.

El usuario podrá ingresar, por ejemplo: '3 + 5 * 2', la función calculará la expresión y devolverá el resultado '13'"

function calcular(texto) 
    n = length(texto) #se le asigna a la variable n la cantidad de caracteres en la cadena
    if texto[1] == '(' #si el primer caracter es un paréntesis, se ejecuta la función "eliminar_parentesis" para eliminar los paréntesis redundantes
    	texto = eliminar_parentesis(texto) #se actualiza "texto" como el resultado de la función "eliminar_parentesis"
    end
    if num_valido(texto) #si el número dentro de la cadena es válido, leerlo y convertirlo de cadena a número, esto no se cumple cuando no es un número(es un operador). Esto se da después de haber separado y ya no existan más operadores, por lo que regresará un solo número operable.
        return parse(Float64, texto) #devuelve el número ahora como tipo de dato float(número), no como cadena de texto
    else #si es un operador
    	ind_op = encontrar_operador('+', texto) #se ejecuta la función "encontrar_operdor" que recibe como argumentos el caracter suma y la cadena
        if ind_op == 1 #si el operador está en la primera posición, error
            throw("Falta un a expresión o número antes de <$texto>") #error
        elseif ind_op == n #si el operador está en la última posiciíon, error
            throw("Falta un a expresión o número después de <$texto>") #error
    	elseif ind_op != 0 #si el índice es diferente de 0, es porque existe la suma dentro de la cadena, por esto, el resultado es algo operable. Con esto, separa y se vuelve a correr. Si es igual a 0, se vuelve a definir ind_op para buscar el producto
    		return calcular(texto[1:ind_op-1]) + calcular(texto[ind_op+1:end]) #separa los operandos de la suma y se vuelve a correr la función "calcular" con ambos operandos
    	else #al dar 0, no se encontró la suma y empieza a buscar el producto
    		ind_op = encontrar_operador('*', texto) #se ejecuta la función "encontrar_operdor" que recibe como argumentos el caracter procucto y la cadena
            if ind_op == 1 #si el operador está en la primera posición, error
                throw("Falta un a expresión o número antes de <$texto>") #error
            elseif ind_op == n #si el operador está en la última posiciíon, error
                throw("Falta un a expresión o número después de <$texto>") #error
            elseif ind_op != 0 #al existir la multiplicación divide la cadena en dos y regresa el resultado de "calcular" del primer operando y del segundo operando
    			return calcular(texto[1:ind_op-1]) * calcular(texto[ind_op+1:end]) #separa los operandos de la multiplicación y se vuelve a correr la función "calcular" con ambos operandos
    		else 
<<<<<<< HEAD
    			throw("En <$texto>, existe un uso de los paréntesis indevido.") #No hay problemas con los operadores, el único error posible es cuando validar paréntesis no fue ejecutado porque no empezaba en '('
=======
    			throw("En <$texto>, existe un uso de los paréntesis indebido.") #No hay problemas con los operadores, el único error posible es cuando validar paréntesis no fue ejecutado porque no empezaba en '('
>>>>>>> 85fd81d (Ya por favor)
    		end
    	end
    end
end #fin de la función
