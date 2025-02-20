<script setup lang="ts">
import { useCollectionList } from '@/composables/useCases/useCollectionList'
import { useApiClient } from '@/composables/ApiClient'
const router = useRouter()

definePageMeta({
  title: 'Collections',
  breadcrumb: [
    { label: 'Admin', to: '/admin' },
    { label: 'Collections', to: '/admin/collections/' },
  ],
})

const { collections, q, filteredCollections, getCollections } = useCollectionList()

const columns = ref([
  { label: 'Table Name', key: 'name' },
  { label: 'Roles', key: 'roles' },
  { label: 'Actions', key: 'actions' },
])
const selectedColumns = ref([...columns.value])
const isSubmitting = ref(true)
const isOpen = ref(false)

async function handleDelete(row: any) {
  try {
    await useApiClient.deleteCollection(row.name)
    await getCollections()
  } catch (error) {
    console.error('Error deleting collection:', error)
  }
}

function items(row: any) {
  return [
    [{
      label: 'Fields',
      icon: 'i-heroicons-pencil-square-20-solid',
      click: () => router.push(`${router.currentRoute.value.fullPath}edit/${row.name}`),
    }, {
      label: 'Permissions',
      icon: 'eos-icons:role-binding',
      click: () => router.push(`${router.currentRoute.value.fullPath}permissions/${row.name}`),
    }],
    [{
      label: 'Delete',
      icon: 'i-heroicons-trash-20-solid',
      click: () => handleDelete(row),
    }],
  ]
}

onMounted(async () => {
  await getCollections()
  isSubmitting.value = false
})
</script>

<template>
  <div>
    <div v-if="isSubmitting" class="-mt-6 pb-6">
      <UProgress size="xs" animation="carousel" />
    </div>
    <div class="flex justify-between items-center px-3 py-3.5 border-b border-gray-200 dark:border-gray-700">
      <div class="flex space-x-4">
        <UInput v-model="q" placeholder="Filter collections..." />
        <USelectMenu v-model="selectedColumns" :options="columns" multiple placeholder="Columns" />
      </div>
    </div>

    <UTable :rows="filteredCollections" :columns="selectedColumns">
      <template #caption>
        <caption id="rows" class="text-xs text-gray-500 text-right pr-4 py-3">
          {{ collections.length }} rows in collections
        </caption>
      </template>

      <template #empty-state>
        <div class="flex flex-col items-center justify-center py-6 gap-3">
          <span class="italic text-sm">No item here!</span>
          <UButton label="Add something" @click="isOpen = true" />
        </div>
      </template>

      <template #actions-data="{ row }">
        <UDropdown :items="items(row)">
          <UButton
            color="gray"
            variant="ghost"
            icon="i-heroicons-ellipsis-horizontal-20-solid"
            class="w-8 h-8 flex justify-center items-center"
          />
        </UDropdown>
      </template>
    </UTable>
  </div>
</template>
