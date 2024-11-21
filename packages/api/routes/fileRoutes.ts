/**
 * Initializes the Hono router and defines the file-related routes.
 *
 * @remarks
 * There is a potential security issue in this implementation. Any authenticated user has access to any file.
 * Ideally, only the user who uploaded the file or users with specific roles should have access.
 * Consider implementing user-specific access control using the AuthService from [#file:authService.ts](#file:authService.ts-context).
 *
 * @module fileRoutes
 */
import { Hono } from 'hono'
import { fileService } from '../services/fileService'

// Initialize Hono router
const fileRoutes = new Hono()

fileRoutes.post('/upload', fileService.uploadFile)
fileRoutes.get('/list', fileService.listFiles)
fileRoutes.get('/', fileService.listDates)
fileRoutes.get('/download', fileService.downloadFile)
fileRoutes.delete('/delete', fileService.deleteFile)

export { fileRoutes }