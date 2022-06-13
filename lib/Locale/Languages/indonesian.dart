import 'package:get_storage/get_storage.dart';

Map<String, String> indonesian() {
  final box = GetStorage();
  return {
    'sadaqahnow': 'Sedekah Sekarang',
    'puasawajib': 'Hari yang diwajibkan berpuasa',
    'puasasunat': 'Hari yang disunatkan berpuasa',
    'puasaharam': 'Hari yang diharamkan berpuasa',
    'calendar': 'Kalendar',
    'morecollection': 'Lebih Banyak Koleksi',
    'updateBmi': 'Kemas kini BMI',
    'readmore': 'Lagi',
    'update_error': 'Sila isi berat dan tinggi!',
    'setting_profile': 'Tetapan',
    'update_profile': 'Kemas kini Profil',
    'enterText_profile': 'Sila masukkan beberapa teks',
    'success_profile': 'Kemas kini profil berjaya',
    'heightcm_profile': 'Tinggi (cm)',
    'weightkg_profile': 'Berat (kg)',
    'update_profile_button': 'Kemas kini',
    'language_profile': 'Bahasa',
    'aboutUs_profile': 'Tentang Kami',
    'notification_history': 'Sejarah Notifikasi',
    'sunnah_reminder': 'Peringatan',
    'welcome_home': 'Selamat datang!',
    'option_profile': 'Pilihan',
    'camera_profile': 'Kamera',
    'gallery_profile': 'Galeri',
    'remove_profile': 'Padam',
    'visitour_profile': 'Lawati ',
    'website_profile': 'laman web ',
    'fmi_profile': 'kami untuk maklumat yang lebih lanjut',
    'enterMobileNumber': 'Masukkan nombor telefon cth:13 xxx xxxx',
    'getStarted': 'Daftar',
    'enterFullName': 'Masukkan nama penuh',
    'enterEmailAddress': 'Masukkan alamat emel',
    'enterPassword': 'Masukkan kata laluan',
    'enterPhoneNumber': 'Masukkan nombor telefon',
    'reenterPassword': 'Masukkan semula kata laluan',
    'other': 'Lain-lain',
    'privacyPolicy': 'Polisi Peribadi',
    'and': 'dan',
    'termCondition': 'Terma & Syarat',
    'language': 'Bahasa',
    'email': 'E-mel',
    'name': 'Nama',
    'subject': 'Subjek',
    'emailMessage': 'Mesej',
    'submit': 'Hantar',
    'registerNow': 'Daftar sekarang',
    'register': 'Daftar',
    'registerToContinue': 'Daftar sekarang untuk meneruskan',
    'about': 'Tentang',
    'aboutUs':
        'As-Sunnah adalah syarikat Muslim yang komited untuk membantu umat Islam di seluruh dunia bagi memudahkan mengamalkan amalan sunnah dengan istiqamah melalui inovasi, sains, dan teknologi terkini.',
    'save': 'Simpan',
    'logout': 'Keluar',
    'lorem':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed melakukan eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    'skip': 'Log Masuk',
    'tagline': 'Memberkati Kehidupan ',
    'usingTechnology':
        'As-Sunnah menggunakan inovasi, sains dan teknologi terkini bagi memudahkan Muslim di serata dunia mengamalkan sunnah secara istiqamah.',
    'asSunnahApp': 'Istiqamah App',
    'enterCorrentOTP': 'Sila masukkan OTP yang betul dihantar ke',
    'verifyPhoneNumber': 'Sahkan nombor telefon',
    'verifyDescription':
        'Kami telah menghantar SMS dengan kod pengesahan kepada',
    'listeningOTP': 'Mendengar untuk OTP',
    'or': 'Atau',
    'enterOTP': 'Masukkan OTP',
    'sendingOTP': 'Menghantar OTP',
    'resetPasswordSent': 'Tetapkan semula kata laluan dihantar',
    'inputCorrectEmail': 'Sila masukkan alamat e-mel yang betul',
    'yourEmail': 'Email anda',
    'resetPassword': 'Lupa kata laluan',
    'resetPasswordDesc':
        'Masukkan alamat e-mel anda dan kami akan menghantar pautan kepada anda untuk menetapkan semula kata laluan anda.',
    'verificationCode': 'Kod Pengesahan',
    'otpDescription':
        'Sila masukkan OTP yang dihantar\n pada no telefon berdaftar anda',
    'resentOTP': 'Hantar',
    'successVerified': 'Akaun anda berjaya disahkan',
    'authenticationFailed': 'Pengesahan gagal',
    'otpSuccessSend': 'OTP telah berjaya dihantar',
    'yes': 'Ya',
    'no': 'Tidak',
    'confirmToLogout': 'Mengesahkan untuk log keluar?',
    'exitApp': 'Keluar Aplikasi',
    'confirmExitApp': 'Adakah anda mahu keluar dari aplikasi?',
    'waterIntakeError':
        'Ralat. Sila tetapkan sekurang-kurangnya satu peringatan untuk pengambilan air',
    'habbatusMadu': 'Madu + Habbatus sauda',
    'beforeWaterReminder':
        'Ruang tinggi serta berat perlu diisi sebelum peringatan untuk minum air dapat diaktifkan',
    'HH': 'Madu + Habbatus sauda',
    'navigationHome': 'Laman utama',
    'navigationReminder': 'Peringatan',
    'navigationHistory': 'Sejarah notifikasi',
    'navigationSettings': 'Tetapan',
    'snoozeReminder': 'Peringatan tunda',
    'snoozeProduct': 'Peringatan Afiyah tunda',
    'snoozeTahajjud': 'Peringatan tahajjud tunda',
    'snoozeSadaqah': 'Peringatan sedekah tunda',
    'snoozeWater': 'Peringatan air tunda',
    'snoozeMedicine':
        'Peringatan ${box.read('medicine') ?? 'medicine 1'} tunda',
    'snoozeMedicine2':
        'Peringatan ${box.read('medicine2') ?? 'medicine 2'} tunda',
    'takeWaterReminderToday': 'Jangan lupa ambil air anda, hari ini!',
    'delete': 'Padam',
    'skipToday': 'dilangkau, hari ini',
    'skipAfiyah': 'Peringatan Afiyah dilangkau',
    'takeAfiyahLater': 'Ambil Afiyah nanti',
    'takeAfiyahNow': 'Ambil Afiyah sekarang',
    'doYour': 'Buat',
    'perform': 'Solat',
    'give': 'Keluarkan',
    'drink': 'Minum',
    'panadolSkip': 'Peringatan',
    'panadolReminder': 'dilangkau',
    'skipWater': 'Peringatan air dilangkau',
    'skipTahajjud': 'Peringatan tahajjud dilangkau',
    'skipSedekah': 'Peringatan sedekah dilangkau',
    'now': 'sekarang',
    'takeYour': 'Ambil',
    'later': 'nanti',
    'takeMedicineLater': 'Ambil ubat nanti',
    'editTime': 'Edit Masa',
    'skipNotification': 'Langkau',
    'markAsDone': 'Tandakan dibaca',
    'snooze': 'Tunda selama 5 minit',
    'tooltipEdit': 'Klik untuk mengedit masa',
    'addToBookmark': 'Tambah pada penanda halaman',
    'tapToFav':
        'Klik ikon bintang untuk menambah Al-Quran/Hadis pada senarai penanda halaman anda',
    'add': 'Tambah',
    'done1': 'Selesai',
    'back': 'Kembali',
    'selectTime': 'Pilih Masa',
    'cancelWaterReminder': 'Peringatan air dibatalkan',
    'cancelTahajjudReminder': 'Peringatan tahajjud dibatalkan',
    'cancelSadaqahReminder': 'Peringatan sedekah dibatalkan',
    'cancelReminder1':
        'Peringatan ${box.read('medicine1') ?? 'ubat 1'} dibatalkan',
    'cancelReminder2':
        'Peringatan ${box.read('medicine2') ?? 'ubat 2'} dibatalkan',
    'update': 'Kemas kini',
    'medicineNameUpdated': 'Nama ubat dikemas kini',
    'medicineUpdated': 'Ubat dikemas kini',
    'pleaseFillAllFields': 'Sila isi semua maklumat',
    'editMedicineTitle': 'Edit Ubat',
    'editMedicineName': 'Nama ubat',
    'Acknowledgement_text':
        'Aplikasi mudah alih Istiqamah daripada As-Sunnah Global Ventures dibangunkan dengan kerjasama fakulti Universiti Teknologi MARA (UiTM) berikut:',
    'Acknowledgement_text1': 'Fakulti Sains Komputer & Matematik',
    'Acknowledgement_text2': 'Fakulti Perubatan',
    'Acknowledgement_text3': 'Fakulti Sains Sukan & Rekreasi',
    'Acknowledgement_text4': 'Akademi Pengajian Islam Kontemporari',
    'Acknowledgement_text5': 'Fakulti Sains Gunaan',
    'Acknowledgement_text6': 'Fakulti Seni Lukis dan Reka Bentuk',
    'timeReminder': 'Masa : ',
    'medicineNo1': 'Ubat 1',
    'medicineNo2': 'Ubat 2',
    'glassOfWater': 'gelas air \n(250ml/gelas) setiap hari',
    'afiyah': 'Afiyah',
    'tahajjudcategory': 'Tahajjud',
    'tahajjud1': 'tahajjud',
    'sadaqah': 'sedekah',
    'sadaqah1': 'Sedekah',
    'water1': 'air',
    'water2': 'Air',
    'asian': 'asia',
    'general': 'umum',
    'categories': 'Kategori',
    'search': 'Cari',
    'bookmarks': 'Penanda buku',
    'searchQH': 'Cari Ayat-Ayat Al-Quran atau Hadis',
    'QHrelated': 'Quran atau Hadis berkaitan dengan',
    'afiyahReminder': 'Peringatan Produk Afiyah',
    'medicine1': 'Ubat',
    'who': 'WHO',
    'reminder': 'Peringatan',
    'showAllReminder': 'Tunjuk semua peringatan',
    'editMedicine': 'Edit nama ubat',
    'ofTheDay': 'Potongan ayat Al-Quran/Hadis hari ini\n',
    'collectionQH': 'Koleksi ayat Al-Quran dan Hadis',
    'tahajjudReminder': 'Peringatan Tahajjud',
    'sadaqahReminder': 'Peringatan Sedekah',
    'waterReminder': 'Peringatan Air',
    'setNotificationTime': 'Tetapkan masa peringatan anda',
    'markAll': 'Semua dibaca',
    'deleteAll': 'Padam semua',
    'Acknowledgement_profile': 'Penghargaan',
    'required': 'Diperlukan',
    'helpdesk': 'Meja bantuan',
    'sentEmail': '(Hantar e-mel)',
    'categoryBMItable': 'Rujuk jadual BMI untuk \nmenyemak kategori anda',
    'emailHandling': 'Masukkan e-mel yang betul (e.g: a@gmail.com)',
    'fullnameHandling': 'Hanya abjad dibenarkan',
    'passwordHandling':
        'Kata laluan anda mesti mengandungi sekurang-kurangnya 8 aksara termasuk dengan sekurang-kurangnya 1 huruf besar,1 huruf kecil dan 1 nombor',
    'repasswordHandling': 'Sila masukkan Kata Laluan yang sama seperti di atas',
    'normalWeight': 'Berat badan normal',
    'loadingScreen':
        'Log masuk ke akaun e-mel anda \nuntuk mengesahkan akaun anda',
    'loadingBack': 'Kembali',
    'letgetstarted': 'Daftar Akaun Anda',
    'letgetstartedmessage':
        'Untuk pengguna kali pertama, sila "Daftar" dengan membuka akaun anda.',
    'hadith': 'Menghidupkan Sunnah',
    'hadithNarrated':
        'Sesiapa yang menghidupkan sunnahku, sesungguhnya dia mencintaiku dan sesiapa yang mencintaiku akan bersama denganku di syurga. \n [(Hadis riwayat Al-Tarmizi (2678)]',
    'login': 'Log Masuk',
    'forgotPassword': 'Terlupa kata laluan?',
    'dontHaveAnAccount': 'Tiada akaun lagi?',
    'WHO1': 'Pengkelasan BMI \nWHO populasi umum',
    'WHO2': 'Pengkelasan BMI \nWHO Asia',
    'bmi': 'Pengkelasan BMI\n',
    'BMItable': 'Jadual BMI',
    'scrollable': '*Boleh diskrol ke kanan',
    'updateYourInformation': 'Kemas kini maklumat anda',
    'dateOfBirth': 'Tarikh lahir',
    'phoneNumber': 'Nombor telefon',
    'address1': 'Alamat 1',
    'address2': 'Alamat 2',
    'address3': 'Alamat 3',
    'city': 'Bandar',
    'state': 'Negeri',
    'postcode': 'Poskod',
    'country': 'Negara',
    'gender': 'Jantina',
    'female': 'Perempuan',
    'male': 'Lelaki',
    'wellnessWatch': 'Wellness Watch',
    'wellnessMessage':
        'Tinggi dan berat badan anda akan digunakan untuk mengira indeks jisim badan (BMI) anda dan pengambilan air harian yang diperlukan. Bangsa digunakan untuk menentukan kategori BMI anda.',
    'height': 'Tinggi (cm)',
    'weight': 'Berat (kg)',
    'enterHeight': 'Masukkan tinggi',
    'enterWeight': 'Masukkan berat',
    'noResult': 'Tiada',
    'noData': 'Tiada data',
    'message': 'Tinggi dan berat anda mesti dalam nombor positif',
    'underWeight': 'Kurang berat badan',
    'fine': 'Berat badan normal',
    'overWeight': 'Berlebihan berat badan',
    'obese': 'Obes',
    'enterCountry': 'Masukkan negara',
    'enterPostCode': 'Masukkan poskod',
    'enterCity': 'Masukkan bandar',
    'enterState': 'Masukkan negeri',
    'enterAddress1': 'Masukkan baris alamat 1',
    'enterAddress2': 'Masukkan baris alamat 2',
    'enterAddress3': 'Masukkan baris alamat 3',
    'title': 'Gelaran',
    'ethnicity': 'Bangsa',
    'fillYourTitle': 'Isikan gelaran anda',
    'fillYourEthnicity': 'Isikan bangsa anda',
    'mr': 'Encik',
    'mrs': 'Puan',
    'selectYourGender': 'Pilih jantina Anda',
    'next': 'Seterusnya',
    'rememberMe': 'Ingat akaun saya',
    'error': 'Ralat.Sila masukkan maklumat yang betul dan cuba sekali lagi',
    'termText': 'Dengan mencipta akaun, anda bersetuju dengan',
    'chooseState': 'Pilih negeri',
    'chooseCity': 'Pilih bandar',
    'pickYourCountry': 'Pilih negara anda',
    'emailSent': 'Pautan pengesahan telah dihantar ke emel anda',
    'haveAnAccount': 'Ada akaun ?',
    'loginNow': 'Log masuk sekarang',
    'fillAllInformation': 'Sila isikan semua maklumat!',
    'success': 'Pengesahan akaun anda berjaya',
    'success1': 'Gambar profil anda berjaya dikemas kini',
    'send': 'Nombor OTP telah berjaya dihantar',
    'product': 'Jangan lupa ambil Afiyah, hari ini!',
    'tahajjud': 'Mari tunaikan solat tahajjud, hari ini!',
    'sedekah': 'Mari sedekah, hari ini!',
    'medicine': 'Jangan lupa ambil ',
    'water': 'Jangan lupa minum segelas(250ml) air, hari ini!',
    'companyHadith':
        '“ Sesiapa yang menghidupkan sunnahku, sesungguhnya dia mencintaiku dan sesiapa yang mencintaiku akan bersama denganku di syurga. “\n',
    'companyHadithNarrated': '[Hadis riwayat Al-Tarmizi (2678)]',
    'proceed': 'Seterusnya',
    'text1':
        'As-Sunnah menggunakan kepakaran dan teknologi terkini untuk membantu anda mengambil ',
    'text2': 'Afiyah',
    'text3':
        ' produk premium madu dan habbatus sauda kami dengan cara yang mudah dan lazat.',
    'text4':
        'Pengambilan produk juga dipermudahkan melalui formula 2 dalam 1 untuk dinikmati dimana saja.',
    'takeMedicine': 'Peringatan untuk mengambil ubat anda',
    'edit_time': 'Edit Masa',
    'view': 'Paparkan',
    'unread': 'Belum dibaca',
    'quranHadith': 'Potongan ayat Al-Quran dan Hadis',
    'strongQuranT':
        '“Dan pada sebahagian malam, lakukanlah solat tahajjud sebagai satu ibadah tambahan bagimu, mudah-mudahan Allah mengangkatmu ke tempat yang terpuji.“ \n\n(QS Al-Isra: 79)',
    'strongHadisT':
        '“Wahai sekalian manusia, sebarkanlah salam, berikanlah makanan dan laksanakanlah solat ketika manusia sedang nyenyak tidur, nescaya kalian masuk syurga dengan selamat.“ \n\n(Hr Al-Tirmidzi 2485)',
    'strongQuranS':
        '“Syaitan itu menjanjikan (menakut-nakutkan) kamu dengan kemiskinan dan kepapaan (jika kamu bersedekah atau menderma), dan ia menyuruh kamu melakukan perbuatan yang keji (bersifat bakhil kedekut); sedang Allah menjanjikan kamu (dengan) keampunan daripadaNya serta kelebihan kurniaNya. Dan (ingatlah), Allah Maha Luas limpah rahmatNya, lagi sentiasa Meliputi PengetahuanNya.“ \n\n(Al-Baqarah 2:268)',
    'strongHadisS':
        '“Abu Hurairah RA meriwayatkan, bahawa Rasulullah SAW telah bersabda: “Apabila mati seorang manusia, terputuslah daripadanya amalannya kecuali tiga perkara: Sedekah jariah atau ilmu yang dimanfaatkan dengannya atau anak yang soleh yang mendoakan baginya.” \n\n(Sahih Muslim: 1631)',
    'strongQuranM':
        '“Dan apabila aku sakit, maka Dialah yang menyembuhkan penyakitku. “\n\n(Al-Syu\'ara\' 26:80)',
    'strongHadisM':
        '“Tidaklah Allah menurunkan penyakit kecuali diturunkan juga ubatnya “\n\n(Sahih Al-Bukhari: 5678) Abu Hurairah RA',
    'strongHadisW':
        'Rasulullah SAW minum sebanyak tiga kali tegukan dengan tiga kali nafas, dan bersabda: Cara ini lebih menghilangka dahaga, lebih sihat dan lebih berkhasiat. Anas berkata: “Maka aku pun minum dengan tiga kali teguk dengan tiga kali nafas ketika minum”.\n\n(Sahih Muslim: 2038)',
    'doaW':
        '”Ya Allah, sesungguhnya aku memohon kepada-Mu ilmu yang bermanfaat, rezeki yang lapang, dan kesembuhan dari segala penyakit”',
    'close': 'Tutup',
    'term1': 'Terma & Syarat\n',
    'term2':
        'Dengan memuat turun atau menggunakan apl, syarat ini akan digunakan secara automatik kepada anda – oleh itu anda harus memastikan anda membacanya dengan teliti sebelum menggunakan apl tersebut. Anda tidak dibenarkan menyalin atau mengubah suai apl, mana-mana bahagian apl atau tanda dagangan kami dalam apa jua cara. Anda tidak dibenarkan mencuba untuk mengekstrak kod sumber apl dan anda juga tidak seharusnya cuba menterjemah apl itu ke dalam bahasa lain atau membuat versi terbitan. Apl itu sendiri dan semua tanda dagangan, hak cipta, hak pangkalan data dan hak harta intelek lain yang berkaitan dengannya, masih tergolong dalam As-Sunnah.\nAs-Sunnah komited untuk memastikan apl itu berguna dan cekap yang mungkin. Atas sebab itu, kami berhak untuk membuat perubahan pada apl atau mengenakan bayaran untuk perkhidmatannya, pada bila-bila masa dan atas sebarang sebab. Kami tidak akan sekali-kali mengecaj anda untuk apl atau perkhidmatannya tanpa menjelaskan kepada anda apa yang anda bayar. \nApl As-Sunnah menyimpan dan memproses data peribadi yang telah anda berikan kepada kami, untuk menyediakan Perkhidmatan kami. Tanggungjawab anda untuk memastikan telefon anda dan akses kepada apl selamat. Oleh itu, kami mengesyorkan agar anda tidak melakukan jailbreak atau root telefon anda, iaitu proses mengalih keluar sekatan dan pengehadan perisian yang dikenakan oleh sistem pengendalian rasmi peranti anda. Ia boleh menjadikan telefon anda terdedah kepada perisian hasad/virus/program berniat jahat, menjejaskan ciri keselamatan telefon anda dan ini mungkin bermakna apl As-Sunnah tidak akan berfungsi dengan betul atau sama sekali. \nApl ini menggunakan perkhidmatan pihak ketiga yang mengisytiharkan Terma dan Syarat mereka. \nPautan kepada Terma dan Syarat penyedia perkhidmatan pihak ketiga yang digunakan oleh apl:\n -Perkhidmatan Google Play\n Anda harus sedar bahawa terdapat perkara tertentu yang As-Sunnah tidak akan bertanggungjawab. Fungsi tertentu apl memerlukan apl itu mempunyai sambungan internet yang aktif. Sambungan boleh menjadi Wi-Fi atau disediakan oleh pembekal rangkaian mudah alih anda, tetapi As-Sunnah tidak boleh bertanggungjawab untuk apl tidak berfungsi pada kefungsian penuh jika anda tidak mempunyai akses kepada Wi-Fi dan anda tidak mempunyai sebarang elaun data anda ditinggalkan. \nJika anda menggunakan apl di luar kawasan dengan Wi-Fi, anda harus ingat bahawa syarat perjanjian dengan pembekal rangkaian mudah alih anda masih akan digunakan. Akibatnya, anda mungkin dicaj oleh pembekal mudah alih anda untuk kos data sepanjang tempoh sambungan semasa mengakses apl atau caj pihak ketiga yang lain. Dalam menggunakan apl, anda menerima tanggungjawab untuk sebarang caj sedemikian, termasuk caj data perayauan jika anda menggunakan apl di luar wilayah asal anda (iaitu wilayah atau negara) tanpa mematikan perayauan data. Jika anda bukan pembayar bil untuk peranti yang anda gunakan apl tersebut, harap maklum bahawa kami menganggap anda telah menerima kebenaran daripada pembayar bil untuk menggunakan apl tersebut. \nSelain itu, As-Sunnah tidak boleh sentiasa bertanggungjawab ke atas cara anda menggunakan apl iaitu Anda perlu memastikan peranti anda kekal dicas – jika ia kehabisan bateri dan anda tidak boleh menghidupkannya untuk menggunakan Perkhidmatan , As-Sunnah tidak boleh menerima tanggungjawab. \nBerkenaan dengan tanggungjawab As-Sunnah untuk penggunaan apl anda, apabila anda menggunakan apl tersebut, adalah penting untuk diingat bahawa walaupun kami berusaha untuk memastikan ia dikemas kini dan betul pada setiap masa, kami bergantung pada ketiga pihak untuk memberikan maklumat kepada kami supaya kami boleh menyediakannya kepada anda. As-Sunnah tidak bertanggungjawab untuk sebarang kerugian, langsung atau tidak langsung, yang anda alami akibat bergantung sepenuhnya pada fungsi apl ini. \nPada satu ketika, kami mungkin ingin mengemas kini apl. Apl kini tersedia pada Android – keperluan untuk sistem (dan untuk mana-mana sistem tambahan yang kami putuskan untuk melanjutkan ketersediaan apl itu) mungkin berubah dan anda perlu memuat turun kemas kini jika anda ingin terus menggunakan apl itu . As-Sunnah tidak berjanji bahawa ia akan sentiasa mengemas kini apl supaya ia berkaitan dengan anda dan/atau berfungsi dengan versi Android yang telah anda pasang pada peranti anda. Walau bagaimanapun, anda berjanji untuk sentiasa menerima kemas kini kepada aplikasi apabila ditawarkan kepada anda, Kami juga mungkin ingin berhenti menyediakan apl itu dan boleh menamatkan penggunaannya pada bila-bila masa tanpa memberi notis penamatan kepada anda. Melainkan kami memberitahu anda sebaliknya, selepas sebarang penamatan, (a) hak dan lesen yang diberikan kepada anda dalam syarat ini akan tamat; (b) anda mesti berhenti menggunakan apl itu dan (jika perlu) padamkannya daripada peranti anda.',
    'term3': '\nPerubahan kepada Terma dan Syarat Ini\n',
    'term4':
        'Kami mungkin mengemas kini Terma dan Syarat kami dari semasa ke semasa. Oleh itu, anda dinasihatkan untuk menyemak halaman ini secara berkala untuk sebarang perubahan. Kami akan memberitahu anda tentang sebarang perubahan dengan menyiarkan Terma dan Syarat baharu pada halaman ini. Terma dan syarat ini berkuat kuasa mulai 2021-12-17',
    'term5': '\nHubungi Kami\n',
    'term6':
        'Jika anda mempunyai sebarang soalan atau cadangan tentang Dasar Privasi kami, jangan teragak-agak untuk menghubungi kami di info@as-sunnah.com',
    'privacy1': 'Dasar Privasi\n',
    'privacy2':
        'As-Sunnah membina aplikasi As-Sunnah sebagai aplikasi Percuma. PERKHIDMATAN ini disediakan oleh As-Sunnah tanpa sebarang kos dan bertujuan untuk digunakan sebagaimana adanya. Halaman ini digunakan untuk memaklumkan pelawat mengenai dasar kami dengan pengumpulan, penggunaan dan pendedahan Maklumat Peribadi jika sesiapa memutuskan untuk menggunakan Perkhidmatan kami. Jika anda memilih untuk menggunakan Perkhidmatan kami, maka anda bersetuju menerima pengumpulan dan penggunaan maklumat yang berkaitan dengan dasar ini. Maklumat Peribadi yang kami kumpul digunakan untuk menyediakan dan menambah baik Perkhidmatan. Kami tidak akan menggunakan atau berkongsi maklumat anda dengan sesiapa kecuali seperti yang diterangkan dalam Dasar Privasi ini. Terma yang digunakan dalam Dasar Privasi ini mempunyai maksud yang sama seperti dalam Terma dan Syarat kami, yang boleh diakses di As-Sunnah melainkan ditakrifkan sebaliknya dalam Dasar Privasi ini',
    'privacy3': '\nPengumpulan dan Penggunaan Maklumat\n',
    'privacy4':
        'Untuk pengalaman yang lebih baik, semasa menggunakan Perkhidmatan kami, kami mungkin memerlukan anda untuk memberikan kami maklumat tertentu yang boleh dikenal pasti secara peribadi. Maklumat yang kami minta akan disimpan oleh kami dan digunakan seperti yang diterangkan dalam dasar privasi ini. Apl ini menggunakan perkhidmatan pihak ketiga yang mungkin mengumpul maklumat yang digunakan untuk mengenal pasti anda. Pautan ke dasar privasi penyedia perkhidmatan pihak ketiga yang digunakan oleh apl: \n-Perkhidmatan Google Play',
    'privacy5': '\nData Log\n',
    'privacy6':
        'Kami ingin memaklumkan kepada anda bahawa apabila anda menggunakan Perkhidmatan kami, sekiranya berlaku ralat dalam apl, kami mengumpul data dan maklumat (melalui produk pihak ketiga) pada telefon anda yang dipanggil Data Log. Data Log ini mungkin termasuk maklumat seperti alamat Protokol Internet (“IP”) peranti anda, nama peranti, versi sistem pengendalian, konfigurasi apl semasa menggunakan Perkhidmatan kami, masa dan tarikh penggunaan Perkhidmatan oleh anda dan statistik lain .',
    'privacy7': '\n"Cookies"\n',
    'privacy8':
        '"Cookies" ialah fail dengan sejumlah kecil data yang biasanya digunakan sebagai pengecam unik tanpa nama. Ini dihantar ke penyemak imbas anda daripada tapak web yang anda lawati dan disimpan pada memori dalaman peranti anda. Perkhidmatan ini tidak menggunakan "cookie" ini secara eksplisit. Walau bagaimanapun, apl itu mungkin menggunakan kod dan perpustakaan pihak ketiga yang menggunakan "kuki" untuk mengumpul maklumat dan menambah baik perkhidmatan mereka. Anda mempunyai pilihan untuk sama ada menerima atau menolak kuki ini dan mengetahui bila kuki dihantar ke peranti anda. Jika anda memilih untuk menolak kuki kami, anda mungkin tidak boleh menggunakan beberapa bahagian Perkhidmatan ini.',
    'privacy9': '\nPembekal Perkhidmatan\n',
    'privacy10':
        'Kami mungkin menggaji syarikat dan individu pihak ketiga atas sebab berikut: \n -Untuk memudahkan Perkhidmatan kami;\n -Untuk menyediakan Perkhidmatan bagi pihak kami;\n-Untuk melaksanakan perkhidmatan berkaitan Perkhidmatan; atau\n-Untuk membantu kami menganalisis cara Perkhidmatan kami digunakan.\n Kami ingin memaklumkan kepada pengguna Perkhidmatan ini bahawa pihak ketiga ini mempunyai akses kepada Maklumat Peribadi mereka. Sebabnya adalah untuk melaksanakan tugas yang diberikan kepada mereka bagi pihak kita. Walau bagaimanapun, mereka bertanggungjawab untuk tidak mendedahkan atau menggunakan maklumat tersebut untuk sebarang tujuan lain.',
    'privacy11': '\nKeselamatan\n',
    'privacy12':
        'Kami menghargai kepercayaan anda dalam memberikan kami Maklumat Peribadi anda, oleh itu kami berusaha untuk menggunakan cara yang boleh diterima secara komersial untuk melindunginya. Tetapi ingat bahawa tiada kaedah penghantaran melalui Internet, atau kaedah storan elektronik adalah 100% selamat dan boleh dipercayai, dan kami tidak dapat menjamin keselamatan mutlaknya.',
    'privacy13': '\nPautan ke Tapak Lain\n',
    'privacy14':
        'Perkhidmatan ini mungkin mengandungi pautan ke tapak lain. Jika anda mengklik pada pautan pihak ketiga, anda akan diarahkan ke tapak tersebut. Ambil perhatian bahawa tapak luar ini tidak dikendalikan oleh kami. Oleh itu, kami amat menasihati anda untuk menyemak Dasar Privasi tapak web ini. Kami tidak mempunyai kawalan ke atas dan tidak bertanggungjawab ke atas kandungan, dasar privasi atau amalan mana-mana tapak atau perkhidmatan pihak ketiga.',
    'privacy15': '\nPrivasi Kanak-kanak\n',
    'privacy16':
        'Perkhidmatan ini tidak menangani sesiapa di bawah umur 13 tahun. Kami tidak mengumpul maklumat yang boleh dikenal pasti secara peribadi daripada kanak-kanak di bawah umur 13 tahun dengan sengaja. Sekiranya kami mendapati bahawa kanak-kanak di bawah 13 tahun telah memberikan kami maklumat peribadi, kami segera memadamkannya daripada pelayan kami. Jika anda seorang ibu bapa atau penjaga dan anda sedar bahawa anak anda telah memberikan kami maklumat peribadi, sila hubungi kami supaya kami dapat melakukan tindakan yang perlu.',
    'privacy17': '\nPerubahan pada Dasar Privasi Ini\n',
    'privacy18':
        'Kami mungkin mengemas kini Dasar Privasi kami dari semasa ke semasa. Oleh itu, anda dinasihatkan untuk menyemak halaman ini secara berkala untuk sebarang perubahan. Kami akan memberitahu anda tentang sebarang perubahan dengan menyiarkan Dasar Privasi baharu pada halaman ini. Dasar ini berkuat kuasa mulai 2021-12-17',
    'privacy19': '\nHubungi Kami\n',
    'privacy20':
        'Jika anda mempunyai sebarang soalan atau cadangan tentang Dasar Privasi kami, jangan teragak-agak untuk menghubungi kami di info@as-sunnah.com.',
    'sQuranP':
        '“Dan perut lebah itu keluar minuman (madu) yang bermacam-macam warnanya, di dalamnya terdapat obat yang menyembuhkan bagi manusia” \n\n(QS. An-Nahl : 69)',
    'sHadithP':
        '“Hendaklah kamu menggunakan dua jenis penawar iaitu: Madu dan Al-Quran”\n\n (HR. Ibnu Majah)',
    'selectIntake': 'Pilih pengambilan ubat setiap hari',
    'intake': ' pengambilan ubat setiap hari',
    'dayAgo': 'hari yang lalu',
    'hourAgo': 'jam yang lalu',
    'minuteAgo': 'minit yang lalu',
    'secondAgo': 'saat yang lalu',
    'justNow': 'sebentar tadi',
    'selectLanguage': 'Pilih bahasa',
  };
}
