
import "dart:io";
import "package:path_provider/path_provider.dart";
import "package:pdf/widgets.dart";
import "package:open_filex/open_filex.dart";

class PdfApi{
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
}) async{
    final bytes = await pdf.save();
    final dir = await getApplicationCacheDirectory();
    final file = File("${dir.path}/$name");
    await file.writeAsBytes(bytes);
    return file;
  }
  static Future openFile(File file) async {
    final url = file.path;

    await OpenFilex.open(url);
  }
 }