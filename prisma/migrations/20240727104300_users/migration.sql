-- CreateTable
CREATE TABLE `users` (
    `userId` CHAR(5) NOT NULL,
    `namaKaryawan` VARCHAR(50) NOT NULL,
    `password` VARCHAR(50) NOT NULL,
    `posisiJabatanId` CHAR(4) NOT NULL,
    `subUnitId` CHAR(4) NOT NULL,

    UNIQUE INDEX `users_userId_key`(`userId`),
    PRIMARY KEY (`userId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `positions` (
    `posisiJabatanId` CHAR(4) NOT NULL,
    `namaPosisiJabatan` VARCHAR(50) NOT NULL,

    UNIQUE INDEX `positions_posisiJabatanId_key`(`posisiJabatanId`),
    PRIMARY KEY (`posisiJabatanId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `subunits` (
    `subUnitId` CHAR(4) NOT NULL,
    `namaSubUnit` VARCHAR(50) NOT NULL,

    UNIQUE INDEX `subunits_subUnitId_key`(`subUnitId`),
    PRIMARY KEY (`subUnitId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `todo_activities` (
    `toDoActivityId` CHAR(5) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `parentActivityId` CHAR(5) NULL,
    `deskripsi` VARCHAR(500) NOT NULL,
    `unitCross` VARCHAR(50) NULL,
    `status` VARCHAR(15) NOT NULL,
    `approvalStatus` VARCHAR(20) NOT NULL,
    `tanggalMulai` DATETIME(3) NOT NULL,
    `tanggalSelesai` DATETIME(3) NULL,
    `tanggalDibuat` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `definisiToDoSelesai` VARCHAR(500) NOT NULL,

    UNIQUE INDEX `todo_activities_toDoActivityId_key`(`toDoActivityId`),
    PRIMARY KEY (`toDoActivityId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `today_activities` (
    `todayActivityId` CHAR(5) NOT NULL,
    `deskripsi` VARCHAR(500) NOT NULL,
    `complexity` VARCHAR(50) NOT NULL,
    `unitCross` VARCHAR(50) NULL,
    `status` VARCHAR(15) NOT NULL,
    `tanggal` DATETIME(3) NOT NULL,
    `jamMulai` DATETIME(3) NOT NULL,
    `jamSelesai` DATETIME(3) NULL,
    `userId` VARCHAR(191) NOT NULL,
    `toDoActivityId` VARCHAR(191) NOT NULL,
    `definisiTodaySelesai` VARCHAR(500) NOT NULL,

    UNIQUE INDEX `today_activities_todayActivityId_key`(`todayActivityId`),
    PRIMARY KEY (`todayActivityId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `users` ADD CONSTRAINT `users_posisiJabatanId_fkey` FOREIGN KEY (`posisiJabatanId`) REFERENCES `positions`(`posisiJabatanId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `users` ADD CONSTRAINT `users_subUnitId_fkey` FOREIGN KEY (`subUnitId`) REFERENCES `subunits`(`subUnitId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `todo_activities` ADD CONSTRAINT `todo_activities_parentActivityId_fkey` FOREIGN KEY (`parentActivityId`) REFERENCES `todo_activities`(`toDoActivityId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `todo_activities` ADD CONSTRAINT `todo_activities_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `today_activities` ADD CONSTRAINT `today_activities_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `today_activities` ADD CONSTRAINT `today_activities_toDoActivityId_fkey` FOREIGN KEY (`toDoActivityId`) REFERENCES `todo_activities`(`toDoActivityId`) ON DELETE RESTRICT ON UPDATE CASCADE;
