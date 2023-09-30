include("interprete_aritmetico_funciones.jl") #se usará la segunda parte del código en


function main() #menú para usar la expresión desde la terminal de julia
	fin = true #se le da el valor de true a la varible "fin" que se usará en el while  
	entrada = "" #da la opción de cadena vacía para poder escribir
	println("\n\t - Calculadora de operaciones aritméticas - ")  #se le dice al usuario que hace el programa
	println("\nSólo se acepta el uso de las operaciones suma y multiplicación.\nUse un doble salto de línea para terminar de escribir.")
	print("\nIngresa la expresión: ")  #se le pide al usuario que ingrese su expresión
	while fin  #mientras se cumple "fin"
		linea = readline()  #se le asigna a la variable "linea" lo que se escribió para que lo interprete y se calcule, se activa con la tecla "enter"
		entrada = entrada * linea #se le concatena a la cadena vacía "entrada", la cadena con la entrada que dió el usuario
		if linea == ""  #si el usuario da una cadena vacía, se actualiza la variable fin con el valor false, es decir que se dió enter dos veces seguidas para terminar de escribir
			fin = false  #se actualiza la variable fin con el valor false para terminar el while 
		end
	end
	entrada = juntar(entrada)  #se empieza el proceso para que la entrada elimine los espacios, tabuladores y salto de líneas llamando a la función "juntar"
    if entrada == "" #si la cadena ingresada está vacía, pasar a la siguiente línea
        throw("La expresión ingresada está vacía.") #Error
    end 
	resultado = calcular(entrada) #asignarle al a variable resultado la salida de todo el proceso
	println("\nEl resultado de la expresión:\n\t", entrada, " = ", resultado) #se dice cual es el resultado de la expresión seguido de un igual

	print("\n\t - Programa Finalizado -") #decir al usuario que se terminó de ejecutar el programa
end


main() #ejecuta función main