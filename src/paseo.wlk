

//Esta clase no debe existir, 
//está para que el test compile al inicio del examen
//al finalizar el examen hay que borrar esta clase
class XXX {
	var talle= null
	var desgaste= null
	var min= null
	var max= null
	var prendas= null
	var ninios= null
	var edad= null
	var juguete = null
	var abrigo = null
}

class Familia {
	var ninios //CONJUNTO de instancias de clase Ninio o subclases
	
	method puedePasear() {
		return ninios.all({ninio => ninio.listoParaSalir()})
	}
	
	method infaltables() {
		return ninios.map({ninio => ninio.prendaInfaltable()}).asSet()
	}
	
	method chiquitos() {
		return ninios.filter({ninio => ninio.esChiquito()})
	}
	
	method pasear() {
		if (self.puedePasear()) {
			ninios.forEach({ninio => ninio.saleAPasear()})
		} else {
			self.error("Esta familia no cumple con las condiciones para dar un paseo")
		}
	}
}

class Ninio {
	var talle //objeto talle
	var edad //numero
	var prendas //CONJUNTO de intancias de subclases de clase Prenda
	
	method talle() = talle
	method edad() = edad
	
	method listoParaSalir() {
		return self.tieneSuficientesPrendas() and self.estaAbrigado() and (self.promedioCalidad() > 8)
	}
	
	method tieneSuficientesPrendas() {
		return prendas.size() >= 5
	}
	method estaAbrigado() {
		return prendas.any({prenda => prenda.nivelAbrigo() >= 3})
	}
	method promedioCalidad() {
		return (prendas.sum({prenda => prenda.nivelCalidad(self)})) / prendas.size()
	}
	
	method prendaInfaltable() {
		return prendas.max({prenda => prenda.nivelCalidad(self)})
	}
	
	method esChiquito() {
		return edad < 4
	}
	
	method saleAPasear() {
		prendas.forEach({prenda => prenda.esUtilizada()})
	}
}

class Problematico inherits Ninio {
	var juguete //instancia de la clase Juguete
	
	override method tieneSuficientesPrendas() {
		return prendas.size() >= 4
	}
	
	override method listoParaSalir() {
		return super() and self.tieneEdadParaJuguete()
	}
	method tieneEdadParaJuguete() {
		return edad.between(juguete.edadMin(), juguete.edadMax())
	}
}


class Juguete {
	var edadMin
	var edadMax
	
	method edadMin() = edadMin
	method edadMax() = edadMax
}


//------Prendas------

class Prenda {
	var talle
	var desgaste = 0 //el desgaste no puede ser un numero negativo
	var abrigo = 1
	
	method desgaste() = desgaste
	method talle() = talle
		
	method nivelDeComodidad(ninioX) {
		return
		if (talle == ninioX.talle()) {
			8
		} else {
			0
		} - self.incomodidadPorDesgaste()
	}
	
	method incomodidadPorDesgaste() {
		return 
		if (self.desgaste().between(0, 3)) {
			self.desgaste()
		} else {
			3
		}
	}
	
	method nivelAbrigo() = abrigo
	method nivelCalidad(ninioX) = abrigo + self.nivelDeComodidad(ninioX)
	
	method esUtilizada() {
		desgaste += 1
	}
	method seUtilizaIzquierda() {
		desgaste += 0.8
	}
	method seUtilizaDerecha() {
		desgaste += 1.2
	}
}



class PrendaPares inherits Prenda {
	var prendaDerecha //intancia class Prenda
	var prendaIzquierda //instancia class Prenda
	
	method izquierdo() = prendaIzquierda
	method derecho() = prendaDerecha
	
	override method nivelDeComodidad(ninioX) {
		return super(ninioX) - self.leCaeMalAChiquitos(ninioX)
	}
	method leCaeMalAChiquitos(ninioX) {
		return
		if (ninioX.esChiquito()) {
			1
		} else {
			0
		}
	}
	
	override method desgaste() {
		return (prendaDerecha.desgaste() + prendaIzquierda.desgaste())/2
	}
	
	method intercambiarPares(prendaParX) {
		if (talle == prendaParX.talle()) {
			var derechoParX = prendaParX.derecho()
			prendaParX.cambiarDerecho(self.derecho())
			self.cambiarDerecho(derechoParX)
		} else {
			self.error("El cambio no es posible porque las prendas son de talles distintos")
		}
	}
	method cambiarDerecho(prendaX) {
		prendaDerecha = prendaX
	}
	
	override method nivelAbrigo() {
		return prendaDerecha.nivelAbrigo() + prendaIzquierda.nivelAbrigo()
	}
	
	override method esUtilizada() {
		prendaDerecha.seUtilizaDerecha()
		prendaIzquierda.seUtilizaIzquierda()
	}
}



class PrendaLiviana inherits Prenda {
	override method nivelDeComodidad(ninioX) {
		return super(ninioX) + 2
	}
	
	override method nivelAbrigo() {
		return abrigoPromedio.prendasLivianas()
	}
}

object abrigoPromedio {
	var prendasLivianas = 1
	
	method prendasLivianas() = prendasLivianas
	method cambiarValorPrendasLivianas(nuevoValor) {
		prendasLivianas = nuevoValor
	}
}


class PrendaPesada inherits Prenda {
	//var abrigo = 3 //no supe modificar el default para las pesadas, hay que hacerlo aclarar el abrigo manualmente
}

//Objetos usados para los talles
object xs {}
object s {}
object m {}
object l {}
object xl{}