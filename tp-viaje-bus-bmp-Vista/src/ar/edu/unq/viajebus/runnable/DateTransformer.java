package ar.edu.unq.viajebus.runnable;

import java.text.SimpleDateFormat;

import org.joda.time.LocalDateTime;
import org.uqbar.arena.bindings.ValueTransformer;

public final class DateTransformer implements ValueTransformer<LocalDateTime, String> {
	public String pattern = "dd/MM/yyyy HH:mm";

	@Override
	public String modelToView(LocalDateTime valueFromModel) {
		if (valueFromModel == null) {
			return null;
		}
		return new SimpleDateFormat(pattern).format(valueFromModel);
	}

	@Override
	public Class<LocalDateTime> getModelType() {
		return LocalDateTime.class;
	}

	@Override
	public Class<String> getViewType() {
		return String.class;
	}

	@Override
	public LocalDateTime viewToModel(String valueFromView) {
		// TODO Auto-generated method stub
		return null;
	}
}
