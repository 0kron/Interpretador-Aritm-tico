include("interprete_aritmetico_funciones.jl")


function main()
	fin = true
	entrada = ""
	println("\n\t - Calculadora de operaciones aritméticas - ")
	println("\nSólo se acepta el uso de las operaciones suma y multiplicación.\nUse un doble salto de línea para terminar de escribir.")
	print("\nIngresa la expresión: ")
	while fin
		linea = readline()
		entrada = entrada * linea
		if linea == ""
			fin = false
		end
	end
	entrada = juntar(entrada)
    if entrada == ""
        throw("La expresión ingresada está vacía.")
    end 
	resultado = calcular(entrada)
	println("\nEl resultado de la expresión:\n\t", entrada, " = ", resultado)

	print("\n\t - Programa Finalizado -")
end


main()