from flask import Flask

app = Flask(__name__)


@app.route("/")
def home():
    # DATA MENTAH OPERASIONAL (Simulasi Log Produksi Rig)
    # Format: [Nama_Rig, Produksi_BBL, Downtime_Jam, Tekanan_PSI]
    raw_data = [
        ["Rig-Alpha", 12500, 1.5, 3100],
        ["Rig-Beta", 9400, 4.2, 2850],
        ["Rig-Gamma", 14100, 0.5, 3150],
        ["Rig-Delta", 6200, 5.8, 2700],
        ["Rig-Epsilon", 11000, 2.0, 3010],
    ]

    # ==========================================
    # PROSES ANALISIS DATA (Statistik Deskriptif)
    # ==========================================
    total_data = len(raw_data)

    # 1. Analisis Volume Produksi (BBL)
    list_produksi = [row[1] for row in raw_data]
    total_produksi = sum(list_produksi)
    rata_produksi = total_produksi / total_data
    produksi_tertinggi = max(list_produksi)

    # 2. Analisis Downtime / Waktu Henti Pompa (Jam)
    list_downtime = [row[2] for row in raw_data]
    rata_downtime = sum(list_downtime) / total_data
    downtime_terlama = max(list_downtime)

    # 3. Analisis Tekanan Pompa Pengeboran (PSI)
    list_tekanan = [row[3] for row in raw_data]
    rata_tekanan = sum(list_tekanan) / total_data

    # 4. Deteksi Anomali Jaringan (Rig yang butuh maintenance karena downtime > 3 jam)
    rig_anomali = [row[0] for row in raw_data if row[2] > 3.0]

    # ==========================================
    # VISUALISASI / TAMPILAN DASHBOARD DASHBOARD
    # ==========================================

    # Loop untuk memasukkan data mentah ke dalam tabel HTML
    table_rows = ""
    for row in raw_data:
        # Beri warna merah pada baris jika rig mengalami anomali (downtime tinggi)
        bg_style = 'style="background-color: #fce8e6;"' if row[2] > 3.0 else ""
        table_rows += f"""
        <tr {bg_style}>
            <td><b>{row[0]}</b></td>
            <td>{row[1]:,} BBL</td>
            <td>{row[2]} Jam</td>
            <td>{row[3]} PSI</td>
        </tr>
        """

    # Template HTML untuk menyajikan Hasil Analisis
    html = f"""
    <html>
    <head>
        <title>Oil & Gas Data Management Analytics</title>
        <style>
            body {{ font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 40px; background-color: #f4f6f9; color: #333; }}
            .container {{ max-width: 950px; margin: auto; background: white; padding: 35px; border-radius: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }}
            h2 {{ color: #2c3e50; border-bottom: 3px solid #2980b9; padding-bottom: 12px; margin-top: 0; }}
            h3 {{ color: #34495e; margin-top: 30px; border-left: 4px solid #2980b9; padding-left: 10px; }}
            
            .metrics-container {{ display: flex; justify-content: space-between; margin: 25px 0; }}
            .metric-card {{ background: #f8fafd; padding: 20px; border-radius: 8px; width: 30%; text-align: center; border-top: 4px solid #2980b9; box-shadow: 0 2px 4px rgba(0,0,0,0.02); }}
            .metric-value {{ font-size: 26px; font-weight: bold; color: #2c3e50; margin-top: 5px; }}
            .metric-title {{ font-size: 12px; color: #7f8c8d; text-transform: uppercase; letter-spacing: 1px; }}
            
            .analysis-box {{ background-color: #eef7f4; border-left: 5px solid #27ae60; padding: 15px; border-radius: 6px; margin: 20px 0; }}
            .alert-box {{ background-color: #fff3cd; border-left: 5px solid #ffc107; padding: 15px; border-radius: 6px; margin: 20px 0; }}
            
            table {{ width: 100%; border-collapse: collapse; margin-top: 15px; font-size: 15px; }}
            th {{ background-color: #34495e; color: white; padding: 12px; text-align: left; }}
            td {{ padding: 12px; border-bottom: 1px solid #e0e0e0; }}
            tr:nth-child(even) {{ background-color: #f9f9f9; }}
            
            .status {{ color: #27ae60; font-style: italic; margin-top: 35px; font-size: 13px; font-weight: bold; text-align: right; }}
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Oil & Gas Rig Production & Downtime Analytics</h2>
            <p style="color: #666;">Sistem Informasi Manajemen Data Operasional Kilang Minyak Real-time.</p>
            
            <div class="metrics-container">
                <div class="metric-card">
                    <div class="metric-title">Total Produksi Lapangan</div>
                    <div class="metric-value">{total_produksi:,} BBL</div>
                </div>
                <div class="metric-card">
                    <div class="metric-title">Rata-rata Downtime</div>
                    <div class="metric-value">{rata_downtime:.2f} Jam</div>
                </div>
                <div class="metric-card">
                    <div class="metric-title">Rata-rata Tekanan</div>
                    <div class="metric-value">{rata_tekanan:.1f} PSI</div>
                </div>
            </div>

            <h3>💡 Hasil Analisis Eksekutif</h3>
            <div class="analysis-box">
                <ul>
                    <li><b>Efisiensi Produksi:</b> Rata-rata output minyak per unit rig mencapai <b>{rata_produksi:,} BBL/Hari</b> dengan performa tertinggi dicapai oleh <b>Rig-Gamma</b> (<b>{produksi_tertinggi:,} BBL</b>).</li>
                    <li><b>Kondisi Mekanis:</b> Tekanan kompresor rata-hari berada di batas aman operasional (${rata_tekanan:.1f}$ PSI).</li>
                </ul>
            </div>

            <div class="alert-box">
                ⚠️ <b>Peringatan Manajemen Risiko:</b> Ditemukan <b>{len(rig_anomali)} unit rig</b> yang melampaui batas ambang kritis downtime (> 3 Jam), yaitu: <b>{', '.join(rig_anomali)}</b>. Direkomendasikan inspeksi lapangan segera.
            </div>

            <h3>📋 Log Data Mentah Operasional (Source)</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID Unit Rig</th>
                        <th>Volume Produksi</th>
                        <th>Durasi Downtime</th>
                        <th>Tekanan Pompa</th>
                    </tr>
                </thead>
                <tbody>
                    {table_rows}
                </tbody>
            </table>

            <p class="status">✓ Status Infrastruktur: Berjalan sukses di Docker Container melalui Nginx Reverse Proxy (Port 80)</p>
        </div>
    </body>
    </html>
    """
    return html


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)