global operadores =  ['+', '*']
global cifras = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '.']

function juntar(texto)
    nueva = ""
    n = length(texto)
    for ind in n
    	char = texto[ind]
        if char != ' ' && char != '\t' && char != '\n'
            nueva = nueva * char
        end
    end
    return nueva
end

function num_valido(texto)
    cuenta = 0
    n = length(texto)
    for ind in 1:n
    	char = texto[ind]
        if !(char in cifras)
        	if !(char in ['+', '*', '(', ')'])
            	throw("El caracter '$char' no pertenece a una expresión válida.")
            else
            	return false
        	end
        elseif char == '.'
            cuenta += 1
            if cuenta > 1
                throw("Un número sólo puede tener un punto decimal")
            end
        end
    end
    return true
end

function eliminar_parentesis(texto)
	n = length(texto)
	if n == 0
		throw("La cadena tiene un par de paréntesis vacío.")
	elseif texto[1] == '('
		ind_final = validar_par(texto)
		if ind_final == n
		        texto = texto[2:end-1] 
		        texto = eliminar_parentesis(texto)
		end
	end
    return texto
end

function validar_par(texto)
    ind = 2
    n = length(texto)
    cuenta = 1
    while ind <= n
        char = texto[ind]
        char_anterior = texto[ind-1]
        if char == '('
            if char_anterior in cifras
                throw("No está aceptado el uso de los paréntesis para multiplicar.")
            elseif char_anterior == ')'
                throw("No es formato válido poner dos grupos en paréntesis juntos.")
            end
            cuenta += 1
        elseif char == ')'
            if char_anterior == '(' 
                throw("La cadena tiene un par de paréntesis vacío.") 
            elseif char_anterior in operadores
                throw("Un paréntesis no puede terminar en un operador aritmético.")
            elseif ind < n && (texto[ind+1] in cifras)
                throw("No está aceptado el uso de los paréntesis para multiplicar.")
            end
            cuenta -= 1
        end
        if cuenta == 0 
        	if ind == n
        		return ind
        	elseif texto[ind+1] != ')'
        		return ind
        	end
        elseif cuenta == -1
            throw("La cadena tiene más ')' de los necesarios.")
        end
        ind += 1
    end
    if cuenta != 0
        throw("La cadena tiene más '(' de los necesarios.")
    else
    	return 0
    end
end

function encontrar_operador(char, texto)
	 i = 1
	 n = length(texto)
	 while i < n
		char_act = texto[i]
	 	if char_act == '('
	 		i += validar_par(texto[i:end]) - 1
	 	elseif char_act == char
	 		return i
	 	end
	 	i += 1 
	 end 
	 return 0
end

function calcular(texto)
    n = length(texto)
    if n == 0
        throw("La expresión aritmética es incompleta.")
    end
    if texto[1] == '('
    	texto = eliminar_parentesis(texto)
    end
    if num_valido(texto)
        return parse(Float64, texto)
    else
    	ind_op = encontrar_operador('+', texto)
    	if ind_op != 0
    		return calcular(texto[1:ind_op-1]) + calcular(texto[ind_op+1:end])
    	else
    		ind_op = encontrar_operador('*', texto)
    		if ind_op != 0
    			return calcular(texto[1:ind_op-1]) * calcular(texto[ind_op+1:end])
    		else
    			throw("La expresión no es válida")
    		end
    	end
    end
end
