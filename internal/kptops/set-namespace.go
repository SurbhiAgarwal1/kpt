// Copyright 2022 The kpt Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package kptops

import (
	"fmt"
	"strings"

	"sigs.k8s.io/kustomize/kyaml/fn/framework"
	"sigs.k8s.io/kustomize/kyaml/yaml"
)

// Simple implementation of set-namespace kpt function, primarily for testing.
func setNamespace(rl *framework.ResourceList) error {
	if rl.FunctionConfig == nil {
		return nil // nothing to do
	}

	if !validGVK(rl.FunctionConfig, "v1", "ConfigMap") {
		return fmt.Errorf("invalid set-namespace function config type: %s/%s; expected v1/ConfigMap", rl.FunctionConfig.GetApiVersion(), rl.FunctionConfig.GetKind())
	}

	data := rl.FunctionConfig.GetDataMap()
	if data == nil {
		return nil // nothing to do
	}

	namespace, ok := data["namespace"]
	if !ok {
		return nil // nothing to do
	}

	for _, n := range rl.Items {
		if isUnknown(n) && n.GetNamespace() == "" {
			continue
		}
		if err := n.SetNamespace(namespace); err != nil {
			return err
		}
	}

	return nil
}

func isUnknown(n *yaml.RNode) bool {
	apiVersion := n.GetApiVersion()
	group := ""
	if i := strings.Index(apiVersion, "/"); i != -1 {
		group = apiVersion[:i]
	}
	// Heuristic: standard Kubernetes groups often have no dots or end in .k8s.io.
	// Custom Resources (CRs) typically have groups with dots (e.g., custom.io).
	if group == "" || group == "apps" || group == "batch" || strings.HasSuffix(group, ".k8s.io") {
		return false
	}
	return true
}


