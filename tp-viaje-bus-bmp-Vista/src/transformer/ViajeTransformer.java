package transformer;

import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.uqbar.arena.bindings.ValueTransformer;

import ar.edu.unq.viajebus.Micro.Viaje;

public final class ViajeTransformer implements ValueTransformer<Viaje, String> {
	public String pattern = "dd/MM/yyyy";
	DateTimeFormatter dtf = DateTimeFormat.forPattern(pattern);

	@Override
	public Viaje viewToModel(String valueFromView) {
		return null;
	}

	@Override
	public String modelToView(Viaje valueFromModel) {
		String origen = valueFromModel.getOrigen();
		String destino = valueFromModel.getDestino();
		String fechaPartida = valueFromModel.getFechaPartida().toLocalDate().toString(pattern);
		String fechaLlegada = valueFromModel.getFechaLlegada().toLocalDate().toString(pattern);
		String res = origen + " " + fechaPartida + " -> " + destino + " " + fechaLlegada;
		return res;
	}
	

	@Override
	public Class<Viaje> getModelType() {
		return Viaje.class;
	}

	@Override
	public Class<String> getViewType() {
		return String.class;
	}

}
