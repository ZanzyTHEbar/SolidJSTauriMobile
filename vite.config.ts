import * as path from 'path'
import { internalIpV4 } from 'internal-ip'
import { defineConfig } from 'vite'
import solidPlugin from 'vite-plugin-solid'

// https://vitejs.dev/config/
export default defineConfig(async () => {
    const host = await internalIpV4()

    /** @type {import('vite').UserConfig} */
    const config = {
        resolve: {
            alias: {
                '@interfaces': path.resolve(__dirname, './src/interfaces'),
                '@components': path.resolve(__dirname, './src/components'),
                '@redux': path.resolve(__dirname, './src/redux'),
                '@pages': path.resolve(__dirname, './src/pages'),
                '@styles': path.resolve(__dirname, './src/styles'),
                '@config': path.resolve(__dirname, './src/config'),
                '@src': path.resolve(__dirname, './src'),
                '@assets': path.resolve(__dirname, './assets'),
                '@hooks': path.resolve(__dirname, './src/utils/hooks'),
                '@static': path.resolve(__dirname, './src/static'),
                '@utils': path.resolve(__dirname, './src/utils'),
            },
        },
        plugins: [solidPlugin()],
        server: {
            host: '0.0.0.0', // listen on all addresses
            port: 3000,
            strictPort: true,
            hmr: {
                protocol: 'ws',
                host,
                port: 5183,
            },
        },
    }
    return config
})
