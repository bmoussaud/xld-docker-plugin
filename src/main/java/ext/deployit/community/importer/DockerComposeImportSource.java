/**
 * THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
 * FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
 */
package ext.deployit.community.importer;

import java.io.File;

import com.xebialabs.deployit.server.api.importer.ImportSource;

public class DockerComposeImportSource implements ImportSource {
    @Override
    public File getFile() {
        return null;
    }

    @Override
    public void cleanUp() {

    }
}
