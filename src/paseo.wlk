

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
	
}

class Ninio {
	var talle //objeto talle
	var edad //numero
	var prendas
	
	method talle() = talle
	method edad() = edad
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
		if (0 <= self.desgaste() and self.desgaste() <= 3) {
			self.desgaste()
		} else {
			3
		}
	}
	
	method nivelAbrigo() = abrigo
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
		if (ninioX.edad() < 4) {
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