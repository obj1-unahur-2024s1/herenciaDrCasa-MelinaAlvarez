class Enfermedad{
	var celulasAmenazadas
	
	method celulasAmenazadas() = celulasAmenazadas
	
	method atenuarCelulas(dosis){
		celulasAmenazadas = 0.max(celulasAmenazadas - dosis)
	}
	
	method estaCurada() = celulasAmenazadas == 0
}

class EnfermedadesInfecciosas inherits Enfermedad{

	method producirEfecto(persona){
		persona.aumentarTemperatura(celulasAmenazadas/1000)
	}
	
	method reproducirse(){
		celulasAmenazadas = celulasAmenazadas*2
	}
	
	method esAgresiva(persona){
		return celulasAmenazadas > persona.celulas()*0.1 
	}
}

class EnfermedadesAutoinmunes inherits Enfermedad{
	var cantEfecto = 0
	
	method producirEfecto(persona){
		persona.destruirCelulas(celulasAmenazadas)
		cantEfecto += 1
	}
	
	method esAgresiva(persona) = cantEfecto > 30
}

object muerte{
	method atenuarCelulas(dosis){}
	method estaCurada() = false
	method producirEfecto(persona){
		persona.temperaturaMortal()
	}
	method esAgresiva(persona) = true
}