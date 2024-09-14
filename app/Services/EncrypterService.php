<?php
namespace App\Services;

class EncrypterService
{
    /**
     * Encrypt the data and return hashed value.
     *
     * @param  mixed  $data
     * @return string
     */
    public function encryptAndHash($data)
    {
        // Using password_hash with BCRYPT algorithm for secure hashing
        $hashed = password_hash($data, PASSWORD_BCRYPT);

        if ($hashed === false) {
            // Handle error, for simplicity, let's throw an exception
            throw new \RuntimeException('Hashing failed');
        }

        return $hashed;
    }

    /**
     * Verify the data against the hashed value.
     *
     * @param  string  $data
     * @param  string  $hashed
     * @return bool
     */
    public function verify($data, $hashed)
    {
        // Using password_verify to check if the data matches the hashed value
        return password_verify($data, $hashed);
    }
}
