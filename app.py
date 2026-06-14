from flask import Flask, render_template, request, redirect, url_for
import psycopg2

app = Flask(__name__)

app.config.from_pyfile('config.py')

def get_db_connection():
    try:
        conn = psycopg2.connect(
            dbname=app.config['harshini'],
            user=app.config['harshini'],
            password=app.config['fccb38f8'],
            host=app.config['10.2.95.122'],
            port=app.config['5432'],
        )
        print("Database connection established successfully")
        return conn
    except psycopg2.Error as e:
        print("Database connection error:", e)
        return None

@app.route('/')
def index():
    conn = get_db_connection()
    if not conn:
        return "Database connection error"

    with conn:
        with conn.cursor() as cur:
            cur.execute("SELECT * FROM exoplanet_info;")
            exoplanet_data = cur.fetchall()

    return render_template('index.html', exoplanet_data=exoplanet_data)



@app.route('/update_planet_data', methods=['POST'])
def update_planet_data():
    conn = get_db_connection()
    if not conn:
        return "Database connection error"

    planet_name = request.form.get('planet_name')

    if not planet_name:
        return "Planet name is required"

    with conn:
        with conn.cursor() as cur:
            cur.execute("SELECT Mass, Radius FROM massradius WHERE Name = %s;", (planet_name,))
            planet_data = cur.fetchone()

            if planet_data:
                mass, radius = planet_data
                density = mass / (4/3 * 3.14159265 * radius * radius * radius)
                cur.execute("UPDATE massradius SET Density = %s WHERE Name = %s;", (density, planet_name))

            cur.execute("SELECT Mass, Radius FROM massradius WHERE Name = %s;", (planet_name,))
            mass_data = cur.fetchall()

            if mass_data:
                total_mass = sum(mass for mass, _ in mass_data)
                total_radius = sum(radius for _, radius in mass_data)
                avg_mass = total_mass / len(mass_data)
                avg_radius = total_radius / len(mass_data)
                cur.execute("UPDATE massradius SET Average_Mass = %s, Average_Radius = %s WHERE Name = %s;", (avg_mass, avg_radius, planet_name))

            cur.execute("SELECT Aop, Eop FROM planet_specifics WHERE Name = %s;", (planet_name,))
            aop_eop_data = cur.fetchone()

            if aop_eop_data:
                aop, eop = aop_eop_data
                periapsis_dist = aop * (1 - eop)
                apoapsis_dist = aop * (1 + eop)
                cur.execute("UPDATE planet_specifics SET Periapsis_Dist = %s, Apoapsis_Dist = %s WHERE Name = %s;", (periapsis_dist, apoapsis_dist, planet_name))

    return redirect(url_for('index'))

@app.route('/insert_record', methods=['POST'])
def insert_record():
    conn = get_db_connection()
    if not conn:
        return "Database connection error"

    planet_name = request.form.get('planet_name')
    mass = request.form.get('mass')
    radius = request.form.get('radius')
    semi_major_axis = request.form.get('semi_major_axis')
    eccentricity = request.form.get('eccentricity')
    star_name = request.form.get('star_name')

    if not planet_name:
        return "Planet name is required"

    with conn:
        with conn.cursor() as cur:
            cur.execute("INSERT INTO exoplanet_info (Name, Mass, Radius) VALUES (%s, %s, %s);", (planet_name, mass, radius))

            cur.execute("INSERT INTO planet_status (Name, Semi_major_axis, Eccentricity) VALUES (%s, %s, %s);", (planet_name, semi_major_axis, eccentricity))

            cur.execute("INSERT INTO stars (Name, Star_name) VALUES (%s, %s);", (planet_name, star_name))

    return redirect(url_for('index'))


@app.route('/delete_record', methods=['POST'])
def delete_record():
    conn = get_db_connection()
    if not conn:
        return "Database connection error"

    planet_id = request.form.get('planet_id_to_delete')

    if not planet_id:
        return "Invalid input data"

    with conn:
        with conn.cursor() as cur:
            cur.execute("DELETE FROM exoplanet_info WHERE Id_n = %s;", (planet_id,))
            cur.execute("DELETE FROM massradius WHERE Id_n = %s;", (planet_id,))
            cur.execute("DELETE FROM planet_specifics WHERE Id_n = %s;", (planet_id,))
            cur.execute("DELETE FROM planet_status WHERE Id_n = %s;", (planet_id,))
            cur.execute("DELETE FROM star_properties WHERE Id_n = %s;", (planet_id,))
            cur.execute("DELETE FROM stars WHERE Id_n = %s;", (planet_id,))

    return redirect(url_for('index'))

app.run(debug=True)
if __name__ == '__main__':
    app.run(debug=True)
