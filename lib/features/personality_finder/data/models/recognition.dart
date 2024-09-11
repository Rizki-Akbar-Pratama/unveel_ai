
import 'dart:ui';
import 'package:image/image.dart' as img;

/// Represents the recognition output from the model
class Recognition {
  final String _cheekbones;
  final String _eyeangle;
  final String _eyedistance;
  final String _eyeshape;
  final double _age;
  final List<Map<String, double>> _landmarks;
  final Map<String, int> _lipsColor;
  final Map<String, int> _eyebrowColor;
  /*
  final String _eyesize;
  final String _eyebrowdistance;
  final String _noselength;
  final String _nosewidth;
  final String _thickness;
  final String _thinnes;
  final String _eyebrowshape;
  final String _eyelid;
  final String _faceshape;
  final String _lip;
  */


  Recognition(this._cheekbones,
      this._eyeangle,
      this._eyedistance,
      this._eyeshape,
      this._age,
      this._landmarks,
      this._lipsColor,
      this._eyebrowColor);
      //this._eyesize,
      //this._eyebrowdistance,
      //this._noselength,
      //this._nosewidth,
      //this._thickness,
      //this._thinnes,
      //this._eyebrowshape,
      //this._eyelid,
      //this._faceshape,
      //this._lip);

  get cheekbones => _cheekbones;
  get eyeangle => _eyeangle;
  get eyedistance => _eyedistance;
  get eyeshape => _eyeshape;
  get age => _age;
  get landmarks => _landmarks;
  get lipColor => _lipsColor;
  get eyebrowColor => _eyebrowColor;
  /*get eyesize => _eyesize;
  get eyebrowdistance => _eyebrowdistance;
  get noselength => _noselength;
  get nosewidth => _nosewidth;
  get thickness => _thickness;
  get thinnes => _thinnes;
  get eyebrowshape => _eyebrowshape;
  get eyelid => _eyelid;
  get faceshape => _faceshape;
  get lip => _lip;*/

  static int findMaxIndex(List<double> output) {
    double maxScore = -double.infinity;
    int maxIndex = -1;
    for (int i = 0; i < output.length; i++) {
      if (output[i] > maxScore) {
        maxScore = output[i];
        maxIndex = i;
      }
    }

    return maxIndex;

  }

  static List<List<double>> reshape(List<double> landmarks) {
    // Konversi ke array 2D [468][3]
    List<List<double>> reshapedArray = [];

    for (int i = 0; i < landmarks.length; i += 3) {
      List<double> sublist = landmarks.sublist(i, i + 3);
      reshapedArray.add(sublist);
    }

    return reshapedArray;
  }

  static List<Map<String, double>> calculateLandmarks(List<List<double>> landmarks){
    // Apply the formula to each coordinate and store the result in a list of maps
    List<Map<String, double>> processedLandmarks = landmarks.map((point) {
      double x = (point[0]) ;
      double y = (point[1]);
      double z = point[2]; // Assuming z doesn't change
      return {'x': x, 'y': y, 'z': z};
    }).toList();
    return processedLandmarks;
  }

  // Fungsi untuk mendapatkan warna rata-rata dari landmark pada bibir
  static Map<String, int> getAverageColorFromLips(
      img.Image imageInput, List<Map<String, double>> landmarks, List<int> target) {
    num totalR = 0;
    num totalG = 0;
    num totalB = 0;
    num totalA = 0;
    int validPoints = 0;

    // Iterasi melalui semua titik bibir
    for (int index in target) {
      int x = landmarks[index]['x']!.toInt();
      int y = landmarks[index]['y']!.toInt();

      // Pastikan koordinat berada dalam rentang gambar
      if (x >= 0 && x < imageInput.width && y >= 0 && y < imageInput.height) {
        // Dapatkan objek pixel di koordinat tersebut
        img.Pixel pixel = imageInput.getPixel(x, y);

        // Tambahkan komponen warna ke total
        totalR += pixel.r;
        totalG += pixel.g;
        totalB += pixel.b;
        totalA += pixel.a;

        validPoints++;
      }
    }

    // Hitung rata-rata komponen warna dan konversi menjadi int
    if (validPoints > 0) {
      int avgR = (totalR / validPoints).round(); // Menggunakan round untuk pembulatan
      int avgG = (totalG / validPoints).round();
      int avgB = (totalB / validPoints).round();
      int avgA = (totalA / validPoints).round();

      return {
        'r': avgR,
        'g': avgG,
        'b': avgB,
        'a': avgA,
      };
    } else {
      // Jika tidak ada poin valid, kembalikan warna hitam dengan alpha 0
      return {
        'r': 0,
        'g': 0,
        'b': 0,
        'a': 0,
      };
    }
  }

  // Fungsi untuk mendapatkan warna rata-rata dari landmark pada bibir
  static Map<String, int> getAverageColorFromEyeBrow(
      img.Image imageInput, List<Map<String, double>> landmarks, List<int> target) {
    num totalR = 0;
    num totalG = 0;
    num totalB = 0;
    num totalA = 0;
    int validPoints = 0;

    // Iterasi melalui semua titik bibir
    for (int index in target) {
      int x = landmarks[index]['x']!.toInt();
      int y = landmarks[index]['y']!.toInt() - 30;

      // Pastikan koordinat berada dalam rentang gambar
      if (x >= 0 && x < imageInput.width && y >= 0 && y < imageInput.height) {
        // Dapatkan objek pixel di koordinat tersebut
        img.Pixel pixel = imageInput.getPixel(x, y);

        // Tambahkan komponen warna ke total
        totalR += pixel.r;
        totalG += pixel.g;
        totalB += pixel.b;
        totalA += pixel.a;

        validPoints++;
      }
    }

    // Hitung rata-rata komponen warna dan konversi menjadi int
    if (validPoints > 0) {
      int avgR = (totalR / validPoints).round(); // Menggunakan round untuk pembulatan
      int avgG = (totalG / validPoints).round();
      int avgB = (totalB / validPoints).round();
      int avgA = (totalA / validPoints).round();

      return {
        'r': avgR,
        'g': avgG,
        'b': avgB,
        'a': avgA,
      };
    } else {
      // Jika tidak ada poin valid, kembalikan warna hitam dengan alpha 0
      return {
        'r': 0,
        'g': 0,
        'b': 0,
        'a': 0,
      };
    }
  }




  @override
  String toString() {
    return 'Recognition(cheekbones: $cheekbones, Eyeangle: $eyeangle, Eyedistance: $eyedistance, Age: $age, Landmarks: $landmarks, LipColor: $lipColor, EyebrowColor: $eyebrowColor';
        /*'Eyeshape: $eyeshape, Eye Size: $eyesize, '
        'Eyebrow Distance: $eyebrowdistance, Nose Length: $noselength, '
        'Nose Width: $nosewidth, Thickness: $thickness, '
        'Thinnes: $thinnes, Eyebrow Shape: $eyebrowshape, '
        'Eyelid: $eyelid, Face Shape: $faceshape, Lips: $lip)';*/
  }
}
