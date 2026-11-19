
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DashboardPage(),
  ));
}

const Color hijau = Color(0xFF006F61);
const Color hijauMuda = Color(0xFFDFF2F0);

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Map<String, String>> _daftarMahasiswa = [
    {
      'nama': 'Enjy valencia farin',
      'nim': '701240090',
      'prodi': 'Sistem Informasi',
      'semester': '5',
      'email': 'enjy@ac.id',
    },
    {
      'nama': 'Liza Hanim',
      'nim': '701240091',
      'prodi': 'Sistem Informasi',
      'semester': '5',
      'email': 'liza@ac.id',
    },
  ];

  Future<void> _bukaForm() async {
    final hasil = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => const FormMahasiswaPage(),
      ),
    );

    if (!mounted || hasil == null) return;

    setState(() {
      _daftarMahasiswa.add(hasil);
    });
  }

  void _bukaDetail(Map<String, String> mahasiswa) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(mahasiswa: mahasiswa),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFB2DFDB),
        foregroundColor: const Color(0xFF003D36),
        elevation: 0,
        title: const Text(
          'Dashboard Akademik',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: hijauMuda,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Prototipe Milestone 1',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  'Total terdaftar: ${_daftarMahasiswa.length} mahasiswa',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Daftar Mahasiswa Aktif',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          ..._daftarMahasiswa.map((mahasiswa) {
            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
                side: const BorderSide(color: Color(0xFFD0DCE0)),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                leading: CircleAvatar(
                  backgroundColor: hijau,
                  child: Text(
                    mahasiswa['nama']![0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  mahasiswa['nama']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'NIM ${mahasiswa['nim']} · Sem ${mahasiswa['semester']}',
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.blueGrey,
                  size: 28,
                ),
                onTap: () => _bukaDetail(mahasiswa),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _bukaForm,
        backgroundColor: hijau,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text(
          'Tambah',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// HALAMAN FORM TAMBAH MAHASISWA

class FormMahasiswaPage extends StatefulWidget {
  const FormMahasiswaPage({super.key});

  @override
  State<FormMahasiswaPage> createState() => _FormMahasiswaPageState();
}

class _FormMahasiswaPageState extends State<FormMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();

  final _nama = TextEditingController();
  final _nim = TextEditingController();
  final _prodi = TextEditingController();
  final _semester = TextEditingController();
  final _email = TextEditingController();

  @override
  void dispose() {
    _nama.dispose();
    _nim.dispose();
    _prodi.dispose();
    _semester.dispose();
    _email.dispose();
    super.dispose();
  }

  Widget kolomInput(
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (nilai) {
          if (nilai == null || nilai.trim().isEmpty) {
            return '$label wajib diisi';
          }
          return null;
        },
      ),
    );
  }

  void _simpan() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'nama': _nama.text.trim(),
        'nim': _nim.text.trim(),
        'prodi': _prodi.text.trim(),
        'semester': _semester.text.trim(),
        'email': _email.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB2DFDB),
        title: const Text('Tambah Mahasiswa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              kolomInput('Nama', _nama),
              kolomInput('NIM', _nim),
              kolomInput('Program Studi', _prodi),
              kolomInput('Semester', _semester),
              kolomInput('Email', _email),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _simpan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: hijau,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(14),
                  ),
                  child: const Text('Simpan'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// HALAMAN DETAIL MAHASISWA

class DetailPage extends StatelessWidget {
  final Map<String, String> mahasiswa;

  const DetailPage({
    super.key,
    required this.mahasiswa,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB2DFDB),
        title: const Text('Detail Mahasiswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 38,
                backgroundColor: hijau,
                child: Text(
                  mahasiswa['nama']![0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            detailBaris('Nama', mahasiswa['nama']!),
            detailBaris('NIM', mahasiswa['nim']!),
            detailBaris('Program Studi', mahasiswa['prodi']!),
            detailBaris('Semester', mahasiswa['semester']!),
            detailBaris('Email', mahasiswa['email']!),
          ],
        ),
      ),
    );
  }

  Widget detailBaris(String judul, String isi) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            judul,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 13,
            ),
          ),
          Text(
            isi,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
