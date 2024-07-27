// Import express
const express = require("express");

// Import validationResult from express-validator
const { validationResult } = require("express-validator");

// Import bcrypt
const bcrypt = require("bcryptjs");

// Import prisma client
const prisma = require("../prisma/client");

// Function register
const register = async (req, res) => {
    // Periksa hasil validasi
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
        // Jika ada error, kembalikan error ke pengguna
        return res.status(422).json({
            success: false,
            message: "Validation error",
            errors: errors.array(),
        });
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(req.body.password, 10);

    try {
        // Insert data
        const user = await prisma.user.create({
            data: {
                userId: req.body.userId,
                namaKaryawan: req.body.namaKaryawan,
                password: hashedPassword,
            },
        });

        // Return response json
        res.status(201).send({
            success: true,
            message: "Register successfully",
            data: user,
        });
    } catch (error) {
        res.status(500).send({
            success: false,
            message: "Internal server error",
            error: error.message, // Adding error message for debugging purposes
        });
    }
};

module.exports = { register };
