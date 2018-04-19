package transformer;

import java.text.SimpleDateFormat;

import org.apache.commons.lang.StringUtils;
import org.joda.time.LocalDateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.uqbar.arena.bindings.ValueTransformer;
import org.uqbar.commons.model.exceptions.UserException;

public final class LocalDateTimeTransformer implements ValueTransformer<LocalDateTime, String> {
	public String pattern = "dd/MM/yyyy HH:mm";
	DateTimeFormatter dtf = DateTimeFormat.forPattern(pattern);

	@Override
	public LocalDateTime viewToModel(String valueFromView) {

		try {
			return StringUtils.isBlank(valueFromView) ? null : dtf.parseLocalDateTime(valueFromView);
		} catch (IllegalArgumentException e) {
			throw new UserException("Debe ingresar una fecha en formato: " + this.pattern);
		}
	}

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

}
