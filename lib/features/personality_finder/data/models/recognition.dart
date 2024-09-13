
import 'dart:ui';
import 'package:image/image.dart' as img;

/// Represents the recognition output from the model
class Recognition {
  final String _cheekbones;
  final String _eyeangle;
  final String _eyedistance;
  final String _eyeshape;
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
  final double _age;
  final List<Map<String, double>> _landmarks;
  final Map<String, int> _lipsColor;
  final Map<String, int> _eyebrowColor;
  final Map<String, int> _hairColor;
  final String _eyeColor;
  final String _personality;
  final List<Map<String, dynamic>> _personalityScore;



  Recognition(this._cheekbones,
      this._eyeangle,
      this._eyedistance,
      this._eyeshape,
      this._eyesize,
      this._eyebrowdistance,
      this._noselength,
      this._nosewidth,
      this._thickness,
      this._thinnes,
      this._eyebrowshape,
      this._eyelid,
      this._faceshape,
      this._lip,
      this._age,
      this._landmarks,
      this._lipsColor,
      this._eyebrowColor,
      this._hairColor,
      this._eyeColor,
      this._personality,
      this._personalityScore);

  get cheekbones => _cheekbones;
  get eyeangle => _eyeangle;
  get eyedistance => _eyedistance;
  get eyeshape => _eyeshape;
  get eyesize => _eyesize;
  get eyebrowdistance => _eyebrowdistance;
  get noselength => _noselength;
  get nosewidth => _nosewidth;
  get thickness => _thickness;
  get thinnes => _thinnes;
  get eyebrowshape => _eyebrowshape;
  get eyelid => _eyelid;
  get faceshape => _faceshape;
  get lip => _lip;
  get age => _age;
  get landmarks => _landmarks;
  get lipColor => _lipsColor;
  get eyebrowColor => _eyebrowColor;
  get hairColor => _hairColor;
  get eyeColor => _eyeColor;
  get personality => _personality;
  get personalityScore => _personalityScore;

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

  static List<Map<String, dynamic>> sortValuesWithIndex(List<double> values) {
    // Hitung total dari semua nilai value
    double total = values.reduce((a, b) => a + b);

    // Membuat list yang berisi pasangan nilai dan indeks serta mengubah value jadi persen
    List<Map<String, dynamic>> indexedValues = values.asMap().entries.map((entry) {
      double percentage = (entry.value / total) * 100;

      // Membatasi angka di belakang koma menjadi dua digit
      percentage = double.parse(percentage.toStringAsFixed(2));

      return {"index": entry.key, "value": percentage};
    }).toList();

    // Mengurutkan berdasarkan nilai dari tertinggi ke terendah
    indexedValues.sort((a, b) => b["value"].compareTo(a["value"]));

    return indexedValues;
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

  // Fungsi untuk mendapatkan warna rata-rata dari landmark pada bibir
  static Map<String, int> getAverageColorFromHair(
      img.Image imageInput, List<Map<String, double>> landmarks, List<int> target) {
    num totalR = 0;
    num totalG = 0;
    num totalB = 0;
    num totalA = 0;
    int validPoints = 0;

    // Iterasi melalui semua titik bibir
    for (int index in target) {
      int x = landmarks[index]['x']!.toInt();
      int y = landmarks[9]['y']!.toInt() + landmarks[1]['y']!.toInt()- 10 ;

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

  // Fungsi untuk mendapatkan warna rata-rata dari landmark dan mengkategorikan warnanya
  static String getAverageColorEye(
      img.Image imageInput, List<Map<String, double>> landmarks, List<int> target) {
    num totalR = 0;
    num totalG = 0;
    num totalB = 0;
    num totalA = 0;
    int validPoints = 0;

    // Iterasi melalui semua titik bibir
    for (int index in target) {
      int x = landmarks[index]['x']!.toInt();
      int y = landmarks[index]['y']!.toInt() - 10;

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
      int avgR = (totalR / validPoints).round();
      int avgG = (totalG / validPoints).round();
      int avgB = (totalB / validPoints).round();
      int avgA = (totalA / validPoints).round();

      // Panggil fungsi categorizeColor untuk mendapatkan kategori warna
      return categorizeColor(avgR, avgG, avgB);
    } else {
      // Jika tidak ada poin valid, kembalikan "black" sebagai kategori warna
      return "black";
    }
  }

// Fungsi untuk menentukan kategori warna berdasarkan RGB
  static String categorizeColor(int r, int g, int b) {
    // Konversi nilai RGB ke HSV untuk kemudahan menentukan kategori
    double hue, saturation, value;
    final double rNorm = r / 255.0;
    final double gNorm = g / 255.0;
    final double bNorm = b / 255.0;

    double max = [rNorm, gNorm, bNorm].reduce((a, b) => a > b ? a : b);
    double min = [rNorm, gNorm, bNorm].reduce((a, b) => a < b ? a : b);

    value = max;
    saturation = max == 0 ? 0 : (max - min) / max;

    if (max == min) {
      hue = 0;
    } else if (max == rNorm) {
      hue = (60 * ((gNorm - bNorm) / (max - min)) + 360) % 360;
    } else if (max == gNorm) {
      hue = (60 * ((bNorm - rNorm) / (max - min)) + 120) % 360;
    } else {
      hue = (60 * ((rNorm - gNorm) / (max - min)) + 240) % 360;
    }

    // Menentukan kategori warna berdasarkan hue
    if (value < 0.1) {
      return 'black';
    } else if (saturation < 0.1) {
      return 'gray';
    } else if (hue >= 0 && hue < 60) {
      return 'red';
    } else if (hue >= 60 && hue < 180) {
      return 'green';
    } else if (hue >= 180 && hue < 270) {
      return 'blue';
    } else if (hue >= 270 && hue < 360) {
      return 'red';  // Bagian hue 300-360 masih cenderung ke red-magenta
    }

    return 'undefined';
  }



  @override
  String toString() {
    return 'Recognition(cheekbones: $cheekbones, Eyeangle: $eyeangle, Eyedistance: $eyedistance, Eye Shape: $eyeshape, Eye Size: $eyesize, Eyebrow Distance: $eyebrowdistance, Eyebrow Shape: $eyebrowshape, Eyelid: $eyelid, Face Shape: $faceshape, Lip: $lip, Nose Length: $noselength, Nose Width: $nosewidth, Thickness: $thickness, Thinnes: $thinnes, Age: $age, Landmarks: $landmarks, LipColor: $lipColor, EyebrowColor: $eyebrowColor, HairColor: $hairColor, EyeColor: $eyeColor, Personality: $personality, Personality Score: $personalityScore)';
  }
}
