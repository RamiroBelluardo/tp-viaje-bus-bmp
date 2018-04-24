package transformer;

import org.apache.commons.lang.StringUtils;
import org.joda.time.LocalDate;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.uqbar.arena.bindings.ValueTransformer;
import org.uqbar.commons.model.exceptions.UserException;

public final class LocalDateTransformer implements ValueTransformer<LocalDate, String> {
	public String pattern = "dd/MM/yyyy";
	DateTimeFormatter dtf = DateTimeFormat.forPattern(pattern);

	@Override
	public LocalDate viewToModel(String valueFromView) {

		try {
			return StringUtils.isBlank(valueFromView) ? null : dtf.parseLocalDate(valueFromView);
		} catch (IllegalArgumentException e) {
			throw new UserException("Debe ingresar una fecha en formato: " + this.pattern);
		}
	}

	@Override
	public String modelToView(LocalDate valueFromModel) {
		if (valueFromModel == null) {
			return null;
		}
		return valueFromModel.toString(pattern);
	}

	@Override
	public Class<LocalDate> getModelType() {
		return LocalDate.class;
	}

	@Override
	public Class<String> getViewType() {
		return String.class;
	}

}
