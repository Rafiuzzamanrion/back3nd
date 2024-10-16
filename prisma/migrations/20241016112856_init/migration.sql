-- CreateTable
CREATE TABLE "back3nd_user" (
    "id" UUID NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "reset_token" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "back3nd_user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "back3nd_role" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "back3nd_role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "back3nd_user_role" (
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "role_id" UUID NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "back3nd_user_role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "back3nd_permission" (
    "id" UUID NOT NULL,
    "role_id" UUID NOT NULL,
    "table_id" UUID NOT NULL,
    "can_create" BOOLEAN NOT NULL DEFAULT false,
    "can_read" BOOLEAN NOT NULL DEFAULT false,
    "can_update" BOOLEAN NOT NULL DEFAULT false,
    "can_delete" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "back3nd_permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "back3nd_some_table" (
    "id" UUID NOT NULL,
    "data_field" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "back3nd_some_table_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "back3nd_password_reset" (
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "token" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expires_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "back3nd_password_reset_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "back3nd_user_email_key" ON "back3nd_user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "back3nd_role_name_key" ON "back3nd_role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "back3nd_user_role_user_id_role_id_key" ON "back3nd_user_role"("user_id", "role_id");

-- CreateIndex
CREATE UNIQUE INDEX "back3nd_permission_role_id_table_id_key" ON "back3nd_permission"("role_id", "table_id");

-- AddForeignKey
ALTER TABLE "back3nd_user_role" ADD CONSTRAINT "back3nd_user_role_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "back3nd_user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "back3nd_user_role" ADD CONSTRAINT "back3nd_user_role_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "back3nd_role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "back3nd_permission" ADD CONSTRAINT "back3nd_permission_table_id_fkey" FOREIGN KEY ("table_id") REFERENCES "back3nd_some_table"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "back3nd_permission" ADD CONSTRAINT "back3nd_permission_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "back3nd_role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "back3nd_password_reset" ADD CONSTRAINT "back3nd_password_reset_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "back3nd_user"("id") ON DELETE CASCADE ON UPDATE CASCADE;
