// Emulate Mysql DATE_FORMAT on h2
drop ALIAS if exists DATE_FORMAT; 
CREATE ALIAS DATE_FORMAT as '
import java.text.SimpleDateFormat;
import java.util.Date;
@CODE
String dateFormat(java.util.Date date, String format) throws Exception { 
    if( date == null ) return "";
    
		String[] replace = {
			"%a", "EEE",
			"%b", "MMM",
			"%c", "MM",
			"%d", "dd",
			"%e", "d",
			"%H", "HH",
			"%h", "hh",
			"%I", "hh",
			"%i", "mm",
			"%j", "DDD",
			"%k", "H",
			"%l", "h",
			"%M", "MMMM",
			"%m", "MM",
			"%p", "a",
			"%r", "hh:mm:ss a",
			"%S", "ss",
			"%s", "ss",
			"%T", "HH:mm:ss",
			"%W", "EEEE",
			"%w", "F",
			"%Y", "yyyy",
			"%y", "yy"
		};

		for(int i=0; i < replace.length - 1; i+=2) {
			format = format.replace(replace[i], replace[i + 1]);
		}

		SimpleDateFormat sf = new SimpleDateFormat(format);
		return sf.format(date);
} 
'