const fs = require('fs');
const semver = require('semver');

const basePath = `${__dirname}/..`;
const getVsixVersion = filename => filename.match(/\d+\.\d+\.\d+/) + "";

const packageJSON = {
    filePath: `${basePath}/package.json`,

    /** @return {{version: string} & {[key: string]: string | {}}} */
    read() {
        return require(this.filePath) || new Error('Failed to load package.json')
    },

    update(/** @type {JSON | string} */ newJSON) {
        const dataObj = (typeof (newJSON) === 'string')
            ? JSON.parse(newJSON) : newJSON;

        if (!dataObj)
            throw new Error('Error readiung input JSON');


        const dataString = JSON.stringify(dataObj, null, 4);
        console.debug('Updating package.json with object: %o', dataObj)
        console.debug('  String form: %s', dataString)

        if (dataString.length > 0)
            fs.writeFileSync(this.filePath, dataString)
        else
            throw new Error('No data in variable being written to package.json')
    },

    lastBuildVersion() {
        const prevBuilds = fs.readdirSync(`${basePath}/packages`);
        const prevVers = prevBuilds.map(getVsixVersion).filter(v => v);

        if (prevVers.length < 1)
            throw new Error('Failed to read version history from previous builds.')

        const latestBuild = semver.sort(prevVers).reverse()[0]

        if (!latestBuild)
            throw new Error('Failed to parse latest build.')

        console.log(`Latest build version: ${latestBuild}`)

        return latestBuild
    },

    /** @private {()=>string} */
    inferNextPatchVersion() {
        const latestBuild = this.lastBuildVersion()
        const newBuildVersion = semver.inc(latestBuild, 'patch')

        console.log(`New build version: ${newBuildVersion}`)

        return newBuildVersion
    },

    updateVersion(/** @type {string?} */ newVersion) {
        const version = (() => {
            if (typeof (newVersion) !== 'string') {
                // Generate next version with patch increment
                return this.inferNextPatchVersion()
            }

            let parsedVer = semver.parse(newVersion);
            if (!parsedVer)
                throw new Error('Failed to parse input version.');

            return parsedVer.version;
        })()

        const srcPkg = this.read()
        srcPkg.version = version;

        this.update(srcPkg)

        console.debug(`Writing updated version: ${version}`)
    }
}

// If invoked directly
if (require.main === module) {
    let version = packageJSON.lastBuildVersion();
    console.log(`Last build version: ${version}`)
    const opt = { isTest: false }
    const args = process.argv
    if (args.length > 0) {
        const argVer = semver.parse(args[0]);
        if (argVer && argVer.version) {
            version = argVer.version;
            console.log(`Building with version: ${version}`)
        }
    }
    console.log('Updating package...')
    packageJSON.updateVersion()
}

module.exports = packageJSON;