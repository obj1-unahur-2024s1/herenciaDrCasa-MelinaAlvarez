import enfermedad.*

class Persona{
	const enfermedades = []
	var property celulas
	var temperatura = 0
	
	
	method temperatura() = temperatura
	method aumentarTemperatura(valor){
		temperatura = 45.min(temperatura + valor)
	}
	method contraer(enfermedad){
		if (enfermedades.size() < 5)
			enfermedades.add(enfermedad)
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
	
	method celAmenazadas(){
		return enfermedades.sum({e=>e.celulasAmenazadas()})
	}
	
	method atenuarEnfermedad(dosis){
		enfermedades.forEach({e=>e.atenuarCelulas(dosis*15)})
		enfermedades.removeAll(enfermedades.filter({e=>e.estaCurada()}))
	}
	
	method temperaturaMortal(){
		temperatura = 0
	}	
}

class Medico inherits Persona{
	var dosis 
	
	method atender(persona){
		persona.atenuarEnfermedad(dosis)
	}
	
	override method contraer(enfermedad){
		super(enfermedad)
		self.atender(self)
	}
}

class JefeMedico inherits Medico{
	const medicos = []
	
	method contratar(medico){
		medicos.add(medico)
	}
	
	method jefeAtiende(persona){
		persona.atenuarEnfermedad(dosis)
	}
	
	override method atender(persona){	
		medicos.anyOne().atender(persona)
	}
	
	override method contraer(enfermedad){
		enfermedades.add(enfermedad)
		self.atenuarEnfermedad(dosis)
	}
}