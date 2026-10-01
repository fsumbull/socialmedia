# Sosyal Medya Yönetim AI Ekibi

Sürüm **0.6.0**. Türkçe içerik ekibi: şef ve araştırmacı ile başlar, gönderinin ihtiyacına göre metin, görsel ve video araçlarını devreye alır. Veriler SQLite’ta uygulama sunucusunda tutulur.

## Kullanım

`Baslat.cmd` dosyasını açın. Başlatıcı tarayıcıda açılır; stüdyoya, AI ve sosyal hesap bağlantılarına, eğitim atölyesine ve geri bildirim formuna buradan geçebilirsiniz. Model dahil Windows paylaşım paketinin kullanımı `ILK-ONCE-OKU.txt` içindedir.

1. **Bağlantılar:** Şef ve araştırmacı zorunludur. Yerel Qwen veya API şefi seçin. Yerel araştırmacı yüklediğiniz belgeleri/RAG’ı araştırır; güncel web için Tavily, Perplexity, Gemini, OpenAI veya OpenRouter seçin. Yerel model tek başına internette arama yapmaz. Yazar/editör seçmezseniz şef üstlenir; medya araçları başta zorunlu değildir.
2. **Şirket profili:** Marka ve hizmet kapsamını 12 soruyla belirleyin. Mimarlık ve VR dahil sektörlere göre seçenekler değişir; kendi ayrıntılarınızı yazabilirsiniz.
3. **Gönderi:** İstenen kanalları ve metin/görsel/kısa video çıktılarını seçin. Görsel veya video aracı eksikse formunuz korunarak aynı ekranda bağlantı penceresi açılır. Anahtarları ekleyip kaldığınız adıma dönün. Ücretli araçlar ayrı kullanım izni ister.
4. **Hazır Şablonlar:** 513 n8n iş akışı Türkçe ve emojisiz sunulur. İlk 10, kaynak görüntülenmelerine göre sıralıdır. **Çalışma alanına uygula** düğmesi görev önizlemesini açar; yeni veya mevcut gönderiyi seçin. Özel odak yazmak isteğe bağlıdır. Şirket profilini tamamlayıp kaydedin, ardından **Ekibi başlat** ile üretime geçin. Şablonun düğüm yapısı şefe referans olur; araştırma, yazı, görsel/video ve editör görevlerine uyarlanan talimatlar kaydedilir. Araçlar sizin bağladığınız API’leri kullanır; görsel/video yalnız seçildiğinde üretilir. Bu bir n8n yürütücüsü değildir: özgün akıştaki kodlar, hesap bağlantıları ve özel düğümler çalıştırılmaz. İçerik kütüphanesiyle aynı alandadır; sahne planı, seslendirme ve medya düzenleme ek araç olarak açılır.
5. **Sosyal hesaplar ve Gönderi Havuzu:** Önce ilgili markanın Instagram/Facebook/LinkedIn hesabını erişim belirteciyle bağlayın; ayrıntılar [Sosyal hesaplar rehberi](docs/SOSYAL-HESAPLAR.md). Üretilen içeriği düzenleyin, kaydedin ve onaylayın. Görsel/video dosyasını dışarıdan da ekleyebilirsiniz. Yayın tarihini seçip havuza alın; aynı kayıt İçerik Takviminde görünür. Plan varken metni değiştirmek için önce planı iptal edin.
6. **LLM Önerileri:** Kullanım amacına göre sağlayıcılara ve anahtar sayfalarına ulaşın. Ücretsiz web aracı, ücretsiz API anlamına gelmez. Hesap kotası ve model erişimi sağlayıcıya bağlıdır.

Şef için OpenAI, Claude, DeepSeek, Gemini ve OpenRouter; görsel için OpenAI/Gemini/OpenRouter; kısa video için Veo/Runway bağlantıları bulunur. Veo/Runway çıktısı 5–8 saniyelik dikey kliptir; uzun montaj değildir. Sağlayıcı alanları düzenlenebilir. Kullanıcı API anahtarları şifreli saklanır ve tarayıcıya geri dönmez.

## Uygulama içinden eğitim

**Eğitim atölyesi → Davranış öğret · Fine-tuning** bölümünde dosya yüklemeden:

- Konuyu, modele sorulacak soru/durumu ve istediğiniz doğru cevabı Türkçe yazın.
- İsterseniz “Yerel modelden cevap taslağı öner” düğmesiyle öneri alın ve düzeltin.
- “Eğitim örneğine dönüştür ve listeye ekle” ile `messages` veri seti arka planda hazırlanır.
- Listeden örneği inceleyip onaylayın; gerektiğinde değiştirin veya çıkarın. Hazır JSON/JSONL metnini doğrudan yapıştırabilir, dosya içe/dışa aktarabilirsiniz.

Kaydetmek model ağırlıklarını değiştirmez. Fine-tuning sırasında Türkçe metin modelin tokenizer’ı ile işlenir; başka dile çeviri zorunlu değildir. Eğitim başlatma, en az 20 eğitim ve 5 doğrulama örneği, uygun donanım ve eğitim ağırlıklarını gerektirir. Ortak sunucuda müşteriler veri hazırlar, model ağırlık eğitimini yönetici yürütür. Bu geliştirmede yeni fine-tuning çalıştırılmadı.

**Bilgi ekle · RAG** bölümünde PDF, DOCX, JSON/JSONL, TXT, MD, CSV ve bilgi paketi eklenir. Embedding arka planda anlam dizini hazırlar; bu fine-tuning değildir. Türkçe öğretim notları için ayrı sekme de korunur. Taranmış PDF’lere OCR uygulanmaz.

## Token, deneme kotası ve sunucu

Müşteri girişi ayrı servis üzerinden çalışır: `npm run start:service` → http://127.0.0.1:4320. Yönetici `node scripts/accounts.mjs create "Müşteri adı"` ile erişim tokeni oluşturur. Her token ayrı kullanıcı alanına bağlanır. İlk **5 gönderi** deneme hakkıdır; kanal başına bir içerik sayılır. Kota dolunca yeni üretim engellenir ve ücretli plan gerektiği gösterilir. Ödeme henüz açılmadı; mevcut içerikler erişilebilir kalır.

Alan adı, HTTPS, token yönetimi, kapasite sınırı, özel dosyaların ayrımı ve yayın bağlantısı: **[Sunucu ve token rehberi](docs/SUNUCU-VE-TOKEN.md)**.

Ayrshare ekranı kaldırıldı. Gönderi Havuzu uygulamanın kendi kuyruğudur; gerçek otonom paylaşım için sunucuya sosyal hesap izinleri olan bir yayın servisi / kendi n8n webhook’unuz bağlanmalıdır. Bağlantısız planlar bekler; kendiliğinden etkinleşmez. Gerçek yayın doğrulanmadıkça “yayınlandı” gösterilmez. Sunucu zamanlanmış yayın için açık kalmalıdır. Bu sürüm doğrudan sosyal ağ OAuth uygulamalarını veya ödeme tahsilatını içermez; internete dağıtım yapılmadı.

## Geliştirme ve yedek

Node.js 24+, `npm install`, `npm test`, `npm run build`. Geliştirme: `npm run dev`. Model: `npm run model`. Yönetici veri yedeği: `npm run backup`. Model dosyası Qwen3-8B Q5_K_M, yaklaşık 5,85 GB; klasör adı MiniLLM korunur.

`server/`: sağlayıcılar, orkestrasyon, SQLite, RAG/eğitim, kuyruk, token girişi. `src/`: Türkçe arayüz. `service-data/`: özel müşteri verileri. `knowledge/workflow-templates.json`: yalnız kamuya açık, temizlenmiş şablonlar. `docs/`: rehberler ve doğrulama kayıtları.

API sözleşmeleri kontrollü test yanıtlarıyla doğrulanır; canlı anahtarlarla ücretli üretim ve gerçek sosyal paylaşım ayrıca sınanmalıdır. Ayrıntılar [doğrulama kaydında](docs/DOGRULAMA.md). Önceki sürüm açıklamaları `docs/ARSIV-0.4-KULLANIM.md` dosyasındadır.
