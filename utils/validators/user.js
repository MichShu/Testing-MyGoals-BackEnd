// Import express-validator
const { body } = require('express-validator');

// Import prisma
const prisma = require('../../prisma/client');

// Definisikan validasi untuk create user
const validateUser = [
    body('userId')
        .notEmpty().withMessage('User ID (NIK) is required')
        .isLength({ min: 5, max: 5 }).withMessage('User ID (NIK) must be 5 characters long')
        .custom(async (value, { req }) => {
            const user = await prisma.user.findUnique({ where: { userId: value } });
            if (user && user.userId !== req.params.id) {
                throw new Error('User ID (NIK) already exists');
            }
            return true;
        }),
    body('namaKaryawan').notEmpty().withMessage('Nama Karyawan is required')
        .isLength({ max: 50 }).withMessage('Nama Karyawan must be at most 50 characters long'),
    body('password')
        .notEmpty().withMessage('Password is required')
        .isLength({ min: 6, max: 50 }).withMessage('Password must be at least 6 characters long and at most 50 characters long'),
    body('posisiJabatanId')
        .notEmpty().withMessage('Posisi Jabatan ID is required')
        .isLength({ min: 4, max: 4 }).withMessage('Posisi Jabatan ID must be 4 characters long')
        .custom(async (value) => {
            const position = await prisma.position.findUnique({ where: { posisiJabatanId: value } });
            if (!position) {
                throw new Error('Posisi Jabatan ID does not exist');
            }
            return true;
        }),
    body('subUnitId')
        .notEmpty().withMessage('Sub Unit ID is required')
        .isLength({ min: 4, max: 4 }).withMessage('Sub Unit ID must be 4 characters long')
        .custom(async (value) => {
            const subUnit = await prisma.subUnit.findUnique({ where: { subUnitId: value } });
            if (!subUnit) {
                throw new Error('Sub Unit ID does not exist');
            }
            return true;
        }),
];

module.exports = { validateUser };
