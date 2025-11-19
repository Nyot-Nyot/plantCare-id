# Sprint 2 — Plant Identification

**Durasi:** 1 minggu
**Goal Sprint:** Implementasi fitur identifikasi tanaman (camera/gallery → Plant.id) lengkap dengan UI hasil, penyimpanan ke koleksi, dan handling offline/caching.

_Catatan:_ Berdasarkan `docs/sprint-planning.md` dan `docs/epics.md`, Sprint 2 fokus pada Epic 1 (Plant Identification). Acceptance criteria utama: confidence score >70%, satu sumber API (Plant.id), image validation, dan caching.

---

## Ringkasan Deliverables

-   Camera integration (viewfinder + overlay tips)
-   Gallery import
-   Client-side image validation & compression
-   Backend orchestrator endpoint untuk Plant.id
-   Result screen (nama lokal & latin, confidence, info singkat)
-   Save result ke collection (local + sync stub)
-   Offline cache untuk hasil identifikasi
-   Unit & integration tests untuk flow utama

---

## Checklist tugas (actionable)

### 1. Environment & config (0.5 - 1h)

[ ] Tambah placeholder API keys di `.env.example`: PLANT_ID_API_KEY, ORCHESTRATOR_URL (0.25h)
[ ] Perbarui README/docs singkat cara menambahkan API keys dan environment untuk dev (0.25-0.5h)

Acceptance criteria:

-   `.env.example` berisi placeholder dan instruksi singkat.

### 2. Client — Camera & Gallery integration (6-8h)

[ ] Tambah dependency camera/image picker sesuai stack proyek (cek `pubspec.yaml`) (0.5h)
[ ] Buat screen `camera_capture_screen.dart`: - Viewfinder - Overlay tips (cara memfokus, jarak ideal) - Tombol capture, flip camera, flash, gallery shortcut (2h)
[ ] Implement gallery pick flow `chooseFromGallery()` (1h)
[ ] Thumbnail preview + retake option sebelum submit (0.5h)
[ ] States: permission denied, camera error (0.5h)
[ ] Responsif terhadap orientation & safe area (0.5h)

Acceptance criteria:

-   User dapat mengambil foto dan memilih dari galeri.
-   UI menunjukkan overlay tips; ada opsi retake/submit.

### 3. Client — Image validation & compression (2-3h)

[ ] Validasi: ukuran file, dimensions minimal (300px), mime type (image/\*) (0.5h)
[ ] Compression pipeline (target <2MB, configurable) + preserve aspect ratio (1-1.5h)
[ ] UX: tampilkan pesan error yang jelas jika invalid; berikan opsi retry atau pilih foto lain (0.5h)

Acceptance criteria:

-   Gambar dikompresi dan tervalidasi; user tidak bisa submit image invalid.

### 4. Backend — Orchestrator endpoint (FastAPI) (4-6h)

[ ] Tambah endpoint POST `/identify` di `backend/main.py` atau modul orchestrator: - Terima multipart image atau image_url - Return JSON terstruktur (id, common_name, scientific_name, confidence, sources, raw_response)
[ ] Integrasi ke Plant.id API; implement retry/backoff and clear error handling jika Plant.id gagal (2-3h)
[ ] Cache hasil identifikasi (Redis/in-memory) dengan TTL 24 jam (0.5-1h)
[ ] Tambah logging, metrics, error handling (0.5-1h)

Acceptance criteria:

-   Endpoint mengembalikan structured JSON; menggunakan Plant.id sebagai sumber tunggal; cached results bekerja; error handling & retry/backoff tersedia.

### 5. Client — API integration & request flow (2-3h)

[ ] Implement `IdentifyService` untuk upload image ke backend `/identify` (0.5h)
[ ] UI: loading skeleton, cancel support (0.5h)
[ ] Error handling: timeouts, server errors, network offline (0.5-1h)
[ ] Parse response & navigate ke `identify_result_screen.dart` (0.5h)

Acceptance criteria:

-   Upload berhasil memicu result screen; errors ditangani dengan pesan yang jelas.

### 6. Client — Identify Result screen (3-4h)

[ ] Buat `IdentifyResultScreen` menampilkan: - Thumbnail image - Common name & scientific name - Confidence score (progress bar + numeric) - Source badge (Plant.id) - Top suggestions (jika available)
[ ] Tindakan: Save to collection, View guide (placeholder), Retake (1.5-2h)
[ ] Jika confidence <70%: tampilkan warning dan action (retake / try gallery) (0.5h)

Acceptance criteria:

-   Result screen jelas, confidence ditampilkan, dan low-confidence menghasilkan guidance untuk ulang foto.

### 7. Client — Save to Collection (local) (2-3h)

[ ] Implement local model & storage (pakai existing local DB layer — Hive/Drift) untuk menyimpan hasil identifikasi (1h)
[ ] UI action save: konfirmasi dan toast; record menyimpan image thumbnail + metadata (1h)
[ ] Sync stub: buat function `syncCollection()` yang akan dipanggil saat online (0.5h)

Acceptance criteria:

-   User bisa menyimpan hasil ke koleksi lokal; data persist antar relaunch.

### 8. Offline & Caching behavior (2h)

[ ] Cache response hasil identifikasi di client (SQLite/Hive) untuk quick lookup (1h)
[ ] Jika offline dan cached result tersedia, tampilkan cached result; jika tidak, tampilkan friendly offline message (1h)

Acceptance criteria:

-   Cached results dapat ditampilkan offline; offline flow jelas for user.

### 9. Tests & QA (2-4h)

[ ] Unit tests untuk `identifyService` (mock backend) (1h)
[ ] Widget tests for Camera screen and IdentifyResultScreen (1-2h)
[ ] End-to-end manual test checklist: camera permissions, compression, API success/error handling, save-to-collection (1h)

Acceptance criteria:

-   Minimal unit + widget tests passing locally; manual QA checklist documented.

---

## Acceptance Criteria (ringkasan dari Epics)

-   Confidence score >= 70% untuk result utama; jika <70% app harus menampilkan warning dan opsi retake.
-   Sistem menggunakan Plant.id sebagai satu-satunya sumber eksternal untuk identifikasi (tidak ada fallback API).
-   Image client-side validation (mime, dims, size) diterapkan dan kompresi berjalan otomatis (target <2MB).
-   User bisa menyimpan hasil identifikasi ke koleksi lokal dan hasil persist antar relaunch.
-   Backend orchestrator mengembalikan JSON terstruktur dan meng-cache hasil (TTL 24 jam).

---

## How to test (QA checklist)

1. Install app on device/emulator.
2. Buka Camera screen, beri permission, ambil foto tanaman.
3. Cek behavior saat foto > limit (seharusnya compress atau reject dengan pesan).
4. Submit photo — verifikasi loading state, result screen muncul.
5. Jika Plant.id unavailable, verifikasi bahwa app menampilkan pesan error yang ramah dan opsi retry (tidak ada fallback API).
6. Save result ke koleksi, restart app, verifikasi entry tersimpan.
7. Tes offline: matikan koneksi, cek cached result tampil; jika belum ada cache tampilkan message.

---

## Estimates & notes

-   Total estimasi sprint: 20-25 SP (sesuai `sprint-planning.md` estimasi 25 SP per sprint). Angka di atas dipecah per tugas; developer dapat meng-breakdown lagi ke ticket/PR per item.
-   Assumsi: Backend minimal orchestration endpoint sudah boleh berada di same repo `backend/`.
-   Jika integrasi API memerlukan billing/credentials, developer harus menyiapkan sandbox keys atau mock server untuk test.

---

## PR checklist

-   [ ] Buat branch `sprint2/<short-description>`
-   [ ] Satu feature per PR, unit tests + widget tests untuk fitur terkait
-   [ ] Update `docs/sprint2/todo.md` marking tasks done per PR
-   [ ] Reviewer: run manual QA checklist before merge

---

Jika ada preferensi library atau constraints (mis. prefer `image_picker` vs `camera`), tandai di issue/PR agar satu gaya dipakai konsisten.

_End of Sprint 2 todo list_
