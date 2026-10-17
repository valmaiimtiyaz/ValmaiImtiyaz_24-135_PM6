class QuizData {
  static final Map<String, List<Map<String, dynamic>>> categories = {
    'Pengetahuan Umum': [
      {
        'question': 'Mamalia laut apakah yang dinobatkan sebagai hewan terbesar di dunia saat ini?',
        'options': ['Hiu Paus', 'Paus Biru', 'Gajah Laut', 'Paus Orca'],
        'correctIndex': 1,
      },
      {
        'question': 'Gunung tertinggi di tata surya kita, Olympus Mons, terletak di planet mana?',
        'options': ['Venus', 'Bumi', 'Mars', 'Jupiter'],
        'correctIndex': 2,
      },
      {
        'question': 'Siapakah tokoh yang dikenal sebagai penemu bola lampu pijar komersial pertama?',
        'options': [
          'Nikola Tesla',
          'Albert Einstein',
          'Alexander Graham Bell',
          'Thomas Alva Edison',
        ],
        'correctIndex': 3,
      },
      {
        'question': 'Berdasarkan luas wilayahnya, negara manakah yang paling kecil di dunia?',
        'options': ['Monako', 'Singapura', 'Vatikan', 'Maladewa'],
        'correctIndex': 2,
      },
      {
        'question':
            'Apa nama samudra terdalam di Bumi tempat Palung Mariana berada?',
        'options': [
          'Samudra Hindia',
          'Samudra Pasifik',
          'Samudra Atlantik',
          'Samudra Arktik',
        ],
        'correctIndex': 1,
      },
    ],

    'Logika & Analisis': [
      {
        'question': 'Jika semua kucing suka ikan, dan Belang adalah seekor kucing. Maka...',
        'options': [
          'Belang benci ikan',
          'Belang suka tikus',
          'Belang suka ikan',
          'Belang tidak makan ikan',
        ],
        'correctIndex': 2,
      },
      {
        'question':
            'Pilihlah kata yang TIDAK termasuk dalam kelompok berikut ini!',
        'options': ['Berenang', 'Menyelam', 'Mendayung', 'Berlari'],
        'correctIndex': 3,
      },
      {
        'question': 'Budi lebih tinggi dari Andi. Cici lebih tinggi dari Budi. Siapa yang paling pendek?',
        'options': ['Andi', 'Budi', 'Cici', 'Tidak ada yang pendek'],
        'correctIndex': 0,
      },
      {
        'question': 'Sebagian penyanyi adalah artis. Semua artis terkenal. Kesimpulan yang tepat adalah...',
        'options': [
          'Semua penyanyi terkenal',
          'Sebagian penyanyi terkenal',
          'Tidak ada penyanyi terkenal',
          'Semua artis adalah penyanyi',
        ],
        'correctIndex': 1,
      },
      {
        'question': 'Jika hari ini hujan, maka jalanan basah. Saat ini jalanan tidak basah. Maka...',
        'options': [
          'Hari ini hujan',
          'Hari ini tidak hujan',
          'Jalanan sedang diperbaiki',
          'Kemarin hujan',
        ],
        'correctIndex': 1,
      },
    ],

    'Tebak Pola': [
      {
        'question': 'Lengkapi deret angka berikut: 2, 4, 8, 16, ...',
        'options': ['24', '32', '64', '128'],
        'correctIndex': 1,
      },
      {
        'question': 'Lengkapi deret huruf berikut: A, C, E, G, ...',
        'options': ['H', 'I', 'J', 'K'],
        'correctIndex': 1,
      },
      {
        'question': '1, 1, 2, 3, 5, 8, ... Angka berapakah selanjutnya? (Deret Fibonacci)',
        'options': ['11', '12', '13', '14'],
        'correctIndex': 2,
      },
      {
        'question':
            'Lengkapi deret angka menurun berikut: 100, 90, 80, 70, ...',
        'options': ['50', '60', '65', '75'],
        'correctIndex': 1,
      },
      {
        'question': 'Lengkapi deret huruf mundur (melompati satu huruf) berikut: Z, X, V, T, ...',
        'options': ['Q', 'R', 'S', 'P'],
        'correctIndex': 1,
      },
    ],
  };
}
