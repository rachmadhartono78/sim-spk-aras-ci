<!-- file: application/views/register.php -->
<html>
<head>
    <title>Register</title>
</head>
<body>
    <h2>Register</h2>
    <?php if ($this->session->flashdata('message')): ?>
        <p><?= $this->session->flashdata('message'); ?></p>
    <?php endif; ?>

    <form action="<?= site_url('Login/register'); ?>" method="post">
        <label for="username">Username:</label>
        <input type="text" name="username" value="<?= set_value('username'); ?>" required><br>

        <?php echo form_error('username'); ?>

        <label for="password">Password:</label>
        <input type="password" name="password" required><br>

        <?php echo form_error('password'); ?>

        <label for="password_confirm">Konfirmasi Password:</label>
        <input type="password" name="password_confirm" required><br>

        <?php echo form_error('password_confirm'); ?>

        <button type="submit">Register</button>
    </form>
</body>
</html>
