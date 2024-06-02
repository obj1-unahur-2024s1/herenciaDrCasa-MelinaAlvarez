class Persona{
	const enfermedades = []
	var property celulas
	var temperatura = 0
	
	
	method temperatura() = temperatura
	method aumentarTemperatura(valor){
		temperatura = 45.min(temperatura + valor)
	}
	method contraer(enfermedad){
		enfermedades.add(enfermedad)
	}
	
	method curarEnfermedad(enfermedad){
		enfermedades.remove(enfermedad)
	}
	
	method destruirCelulas(valor){
		celulas = 0.max(celulas - valor)
	}
	
	method pasaUnDia(){
		enfermedades.forEach({e=>e.producirEfecto(self)})
	}
	
	method celulasAmenazadasPorEnfermedadesAgresivas(){
		return enfermedades.filter({e=>e.esAgresiva(self)}).sum({e=>e.celulasAmenazadas()})
	}
	
	method enfermedadQueMasAfecta(){
		return enfermedades.max({e=>e.celulasAmenazadas()})
	}
	
	method atenuarEnfermedad(dosis){
		enfermedades.forEach({e=>e.atenuarCelulas(dosis)})
		enfermedades.removeAll(enfermedades.filter({e=>e.estaCurada()}))
	}
	
}

class Medico inherits Persona{
	var dosis = 0
	
	method atender(persona){
		persona.atenuarEnfermedad(dosis)
	}
}

class JefeMedico inherits Medico{
	const medicos = []
	
	method contratar(medico){
		medicos.add(medico)
	}
	
	method asignarMedico(persona){
		medicos.anyOne().atender(persona)
	}
}

class Enfermedad{
	var celulasAmenazadas
	
	method celulasAmenazadas() = celulasAmenazadas
	
	method atenuarCelulas(dosis){
		celulasAmenazadas = 0.max(celulasAmenazadas - dosis*15)
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