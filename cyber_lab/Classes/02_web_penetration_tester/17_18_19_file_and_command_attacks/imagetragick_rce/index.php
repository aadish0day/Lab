<?php

if (!empty($_FILES)):

$ext = pathinfo($_FILES['file_upload']['name'], PATHINFO_EXTENSION);
if (!in_array(strtolower($ext), ['gif', 'png', 'jpg', 'jpeg', 'mvg'])) {
    die('Unsupported filetype uploaded.');
}

$size = shell_exec("identify -format '%w x %h' {$_FILES['file_upload']['tmp_name']}");

echo "Image size is: $size";

else:
?>
<!DOCTYPE html>
<html>
<head>
    <title>ImageTragick CVE-2016-3714 Lab</title>
</head>
<body>
    <h2>ImageMagick Profile Picture Upload (CVE-2016-3714)</h2>
    <form method="post" enctype="multipart/form-data">
        <label for="file_upload">Upload Image (.png, .jpg, .gif, .mvg):</label><br><br>
        <input type="file" name="file_upload" id="file_upload"><br><br>
        <input type="submit" value="Upload & Process">
    </form>
</body>
</html>
<?php
endif;
