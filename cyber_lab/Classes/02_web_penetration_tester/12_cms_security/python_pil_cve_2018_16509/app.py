import tempfile
from os import path, unlink

from flask import Flask, flash, make_response, redirect, render_template_string, request
from PIL import Image

app = Flask(__name__)
app.secret_key = "0123456789ABCDEF"


@app.route("/", methods=["GET", "POST"])
def upload_file():
    if request.method == "POST":
        file = request.files.get("image", None)

        if not file:
            flash("No image found")
            return redirect(request.url)

        filename = file.filename
        ext = path.splitext(filename)[1]

        if ext not in [".jpg", ".jpeg", ".png", ".gif", ".bmp"]:
            flash("Invalid extension")
            return redirect(request.url)

        tmp = tempfile.mktemp("test")
        img_path = f"{tmp}.{ext}"

        file.save(img_path)

        img = Image.open(img_path)
        w, h = img.size
        ratio = 256.0 / max(w, h)

        resized_img = img.resize((int(w * ratio), int(h * ratio)))
        resized_img.save(img_path)

        r = make_response()
        r.data = open(img_path, "rb").read()
        r.headers["Content-Disposition"] = f"attachment; filename=resized_{filename}"

        unlink(img_path)

        return r

    return render_template_string("""
    <!doctype html>
    <title>Image Resizer</title>
    <h1>Upload an Image to Resize</h1>
    {% with messages = get_flashed_messages() %}
    {% if messages %}
        <ul class=flashes>
        {% for message in messages %}
        <li>{{ message }}</li>
        {% endfor %}
        </ul>
    {% endif %}
    {% endwith %}
    <form method=post enctype=multipart/form-data>
      <p><input type=file name=image>
         <input type=submit value=Upload>
    </form>
    """)


if __name__ == "__main__":
    app.run(threaded=True, port=8000, host="0.0.0.0")
