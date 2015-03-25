/**
 * THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
 * FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
 */
package com.xebialabs.deployit.plugin.docker.orchestrator;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import com.google.common.base.Function;
import com.google.common.collect.Lists;
import com.google.common.collect.Ordering;

import com.xebialabs.deployit.engine.spi.orchestration.Orchestration;
import com.xebialabs.deployit.engine.spi.orchestration.Orchestrations;
import com.xebialabs.deployit.engine.spi.orchestration.Orchestrator;
import com.xebialabs.deployit.engine.spi.orchestration.SerialOrchestration;
import com.xebialabs.deployit.plugin.api.deployment.specification.Delta;
import com.xebialabs.deployit.plugin.api.deployment.specification.DeltaSpecification;
import com.xebialabs.deployit.plugin.api.udm.Container;
import com.xebialabs.deployit.plugin.api.udm.Deployed;

@Orchestrator.Metadata(name = "docker-deployed-containers-orchestrator", description = "")
public class DockerDeployedContainersOrchestrator implements Orchestrator {
    @Override
    public Orchestration orchestrate(final DeltaSpecification deltaSpecification) {
        List<Delta> sortedDeltas = new Ordering<Delta>() {
            @Override
            public int compare(Delta delta1, Delta delta2) {
                final DeltaUtils du1 = DeltaUtils.instance(delta1);
                final DeltaUtils du2 = DeltaUtils.instance(delta2);
                if (du1.links().isEmpty() && du2.links().isEmpty())
                    return 0;
                if (du1.links().contains(du2.reference()))
                    return du1.links().size();
                if (du2.links().contains(du1.reference()))
                    return -1 * du2.links().size();
                return 0;
            }
        }.sortedCopy(deltaSpecification.getDeltas());

        final List<Orchestration> transformed = Lists.transform(sortedDeltas, new Function<Delta, Orchestration>() {
            @Override
            public Orchestration apply(final Delta delta) {
                return Orchestrations.interleaved("With " + DeltaUtils.instance(delta).deployed().getName(), Collections.singletonList(delta));
            }
        });

        final SerialOrchestration serial = Orchestrations.serial(
                "Serial " + deltaSpecification,
                transformed);
        return serial;

    }

    public static class DeltaUtils {
        private final Delta delta;

        public static DeltaUtils instance(Delta delta) {
            return new DeltaUtils(delta);
        }

        public Deployed<?, ?> deployed() {
            return this.delta.getDeployed() == null ? this.delta.getPrevious() : this.delta.getDeployed();
        }

        public Container container() {
            return deployed().getContainer();
        }

        public Set<String> links() {
            if (deployed().hasProperty("links")) {
                return deployed().getProperty("links");
            } else {
                return Collections.emptySet();
            }
        }

        public DeltaUtils(Delta delta) {
            this.delta = delta;
        }

        public String reference() {
            return String.format("%s:%s", deployed().getName(), deployed().getName());
        }
    }

}
